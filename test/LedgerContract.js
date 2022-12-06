const { expect } = require("chai");

describe("LedgerCOntract", function(){
    it("return the correct name", async function(){
        const contract = await hre.ethers.getContractFactory("LedgerUser")
        const deploy = await contract.deploy("contractName", 3,0,"URI")

        await deploy.deployed();
        console.log("contract lauched")

        expect(await deploy.name()).to.equal("contractName");
        expect(await deploy.ledgerKeyToken()).to.equal(0);
    });

    it("check Key token balance", async function(){
        const contract = await hre.ethers.getContractFactory("LedgerUser")
        const deploy = await contract.deploy("contractName", 3,0,"URI")
        const ownerBalance = await deploy.balanceOf(msg.sender);

        // await deploy.deployed();
        console.log("tokens created")
        console.log(ownerBalance)

        expect(ownerBalance).to.equal(3);
    });
});