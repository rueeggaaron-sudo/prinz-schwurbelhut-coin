// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PrinzSchwurbelhutCoin is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 21_000_000_000; // 0 decimals

    address public treasury;

    uint256 public burnFee = 21; // 2.1% (base 1000)
    uint256 public treasuryFee = 21; // 2.1% (base 1000)
    uint256 public constant FEE_DENOMINATOR = 1000;

    // Limits
    bool public limitsEnabled = true;
    uint256 public maxTxAmount;
    uint256 public maxWalletAmount;

    // Exclude from fees and limits
    mapping(address => bool) public isExcludedFromFees;
    mapping(address => bool) public isExcludedFromLimits;

    event TreasuryUpdated(address indexed newTreasury);
    event FeesUpdated(uint256 burnFee, uint256 treasuryFee);
    event LimitsUpdated(uint256 maxTx, uint256 maxWallet);
    event LimitsStateChanged(bool enabled);
    event ExcludeFromFees(address indexed account, bool isExcluded);
    event ExcludeFromLimits(address indexed account, bool isExcluded);

    constructor(address _treasury) ERC20("Prinz Schwurbelhut Coin", "PSHC") Ownable(msg.sender) {
        require(_treasury != address(0), "Treasury cannot be zero address");
        treasury = _treasury;

        // Mint fixed supply
        _mint(msg.sender, TOTAL_SUPPLY);

        // Default limits
        maxTxAmount = TOTAL_SUPPLY * 1 / 100; // 1%
        maxWalletAmount = TOTAL_SUPPLY * 2 / 100; // 2%

        // Exclude owner and treasury from fees and limits
        isExcludedFromFees[msg.sender] = true;
        isExcludedFromFees[address(this)] = true;
        isExcludedFromFees[_treasury] = true;

        isExcludedFromLimits[msg.sender] = true;
        isExcludedFromLimits[address(this)] = true;
        isExcludedFromLimits[_treasury] = true;
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    // Override _update to handle taxes and limits
    function _update(address from, address to, uint256 value) internal override {
        // If minting or burning (from 0 or to 0), just do standard transfer
        // This avoids recursion when we call _burn inside this function
        if (from == address(0) || to == address(0)) {
            super._update(from, to, value);
            return;
        }

        // Check Limits
        if (limitsEnabled && !isExcludedFromLimits[from] && !isExcludedFromLimits[to]) {
            // Max Tx
            require(value <= maxTxAmount, "Max tx amount exceeded");

            // Max Wallet
            if (to != owner() && to != address(this) && to != treasury) {
                 require(balanceOf(to) + value <= maxWalletAmount, "Max wallet amount exceeded");
            }
        }

        // Calculate Fees
        uint256 burnAmount = 0;
        uint256 treasuryAmount = 0;

        bool takeFee = true;
        if (isExcludedFromFees[from] || isExcludedFromFees[to]) {
            takeFee = false;
        }

        if (takeFee) {
            burnAmount = (value * burnFee) / FEE_DENOMINATOR;
            treasuryAmount = (value * treasuryFee) / FEE_DENOMINATOR;
        }

        uint256 transferAmount = value - burnAmount - treasuryAmount;

        // Perform transfers
        // Standard transfer for the main amount
        super._update(from, to, transferAmount);

        // Burn
        if (burnAmount > 0) {
            _burn(from, burnAmount);
        }

        // Treasury
        if (treasuryAmount > 0) {
            super._update(from, treasury, treasuryAmount);
        }
    }

    // Admin functions
    function setTreasury(address _treasury) external onlyOwner {
        require(_treasury != address(0), "Invalid address");
        treasury = _treasury;
        emit TreasuryUpdated(_treasury);
    }

    function setFees(uint256 _burnFee, uint256 _treasuryFee) external onlyOwner {
        require(_burnFee + _treasuryFee <= 100, "Total fee cannot exceed 10%"); // 100/1000 = 10%
        burnFee = _burnFee;
        treasuryFee = _treasuryFee;
        emit FeesUpdated(_burnFee, _treasuryFee);
    }

    function setLimits(uint256 _maxTx, uint256 _maxWallet) external onlyOwner {
        require(_maxTx >= TOTAL_SUPPLY / 1000, "Max Tx too low"); // Safety check
        require(_maxWallet >= TOTAL_SUPPLY / 1000, "Max Wallet too low");
        maxTxAmount = _maxTx;
        maxWalletAmount = _maxWallet;
        emit LimitsUpdated(_maxTx, _maxWallet);
    }

    function setLimitsEnabled(bool _enabled) external onlyOwner {
        limitsEnabled = _enabled;
        emit LimitsStateChanged(_enabled);
    }

    function setExcludedFromFees(address account, bool excluded) external onlyOwner {
        isExcludedFromFees[account] = excluded;
        emit ExcludeFromFees(account, excluded);
    }

    function setExcludedFromLimits(address account, bool excluded) external onlyOwner {
        isExcludedFromLimits[account] = excluded;
        emit ExcludeFromLimits(account, excluded);
    }
}
