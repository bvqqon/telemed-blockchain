const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("AuditTrailModule", (m) => {
  const auditTrail = m.contract("AuditTrail");

  return { auditTrail };
});
