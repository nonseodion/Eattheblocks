const Oracle = artifacts.require("Oracle");
const { CoinGeckoClient } =  require('coingecko-api-v3');
const POLL_INTERVAL = 5000;

const cgClient = new CoinGeckoClient();

module.exports = async function(done){
  
  const [ _, reporter ] = await web3.eth.getAccounts();
  const oracle = await Oracle.deployed();
  const _switch = true;

  while(true){
    if ( !_switch ) return;

    const {bitcoin} = await cgClient.simplePrice( {ids: "bitcoin", vs_currencies: "usd"} );
    const key = web3.utils.sha3("BTC/USD");
    const currentPrice = bitcoin.usd * 100;
    await oracle.record(key, currentPrice, {from: reporter});
    console.log(`New price of bitcoin, ${currentPrice} updated on the blockchain`);
    _switch = false;
    //await new Promise( resolve => setTimeout( resolve, POLL_INTERVAL ));
  }

  done();
}