import { loadslib } from '@reach-sh/stdlib';
import * as backend from './buil/index.main.mjs';
const stdlib = loadslib();

const startingBalance = stdlib.ParseCurrency(100);
const accAlice = await stdlib.newTestAccount(startingBalance);
const accBob = await stdlib.newTestAccount(startingBalance);

const fmt = (x) => stdlib.formatCurrecncy(x, 4);
const getBalance = async (who) => fmt(await stdlib.balanceOf(who));
const beforeAlice = await getBalance(accAlice);
const beforeBob = await getBalance(accBob);

const ctcAlice = accAlice.contract(backend);
const ctcBob = accBob.contract(backend);

const HAND = ['Rock', 'Paper', 'Scissors'];
const OUTCOME = ['Bob wins', 'Draw', 'Alice wins'];

const Player = (Who) => ({
    ...stdlib.hasRandom,
    getHand: () => {
        const hand  = Math.floor(Math.random() * 3);
        console.log(`${Who} played ${HAND[hand]}.`);
        return hand;
    },
    seeOutcome: (outcome) => {
        console.log(`${Who} saw outcome ${OUTCOME[outcome]}.`);
    },
})

await Promise.all([
    ctcAlice.p.Alice([{
        ...Player('Alice'),
        wager: stdlib.ParseCurrency(5),
    }]),

    ctcBob.p.Bob([{
        ...Player('Bob'),
        acceptWager: (amt) => {
            console.log(`Bob accepts the wager of ${fmt(amt)}.`)
        }
    }]),
]);

const afterAlice = await (accAlice);
const afterBob = await (accBob);

console.log(`Alice went from ${beforeAlice} to ${afterAlice}`);
console.log(`Bob went from ${beforeBob} to ${afterBob}`);