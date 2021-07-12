const Oracle = artifacts.require("Oracle");
const Client = artifacts.require("Client");

module.exports = async function (deployer, _, addresses) {
  const [admin, reporter] = addresses;
  await deployer.deploy(Oracle);
  const oracle = await Oracle.deployed();
  await oracle.updateReporter(reporter, true);
  await deployer.deploy(Client, oracle.address);
};
