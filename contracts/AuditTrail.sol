// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AuditTrail {
    struct LogEntry {
        address actor;
        bytes32 dataHash;
        string metadata;
        uint256 timestamp;
    }

    LogEntry[] public entries;

    event LogAdded(
        uint256 indexed id,
        address indexed actor,
        bytes32 dataHash,
        string metadata,
        uint256 timestamp
    );

    // ❗ УБИРАЕМ onlyWriter, убираем авторизацию
    function addLog(bytes32 _dataHash, string calldata _metadata)
        external
        returns (uint256)
    {
        uint256 id = entries.length;
        entries.push(LogEntry(msg.sender, _dataHash, _metadata, block.timestamp));
        emit LogAdded(id, msg.sender, _dataHash, _metadata, block.timestamp);
        return id;
    }

    function getLog(uint256 id)
        external
        view
        returns (address, bytes32, string memory, uint256)
    {
        LogEntry storage e = entries[id];
        return (e.actor, e.dataHash, e.metadata, e.timestamp);
    }

    function totalEntries() external view returns (uint256) {
        return entries.length;
    }
}
