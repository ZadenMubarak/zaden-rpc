'reach 0.1'

const [isHand, ROCK, PAPER, SCISSORS] = makeEnum(3);
const [ isOoutcome, B_WINS, DRAW, A_WINS] = makeEnum(3)

const winner = (HandAlice, handBob) =>
((HandAlice + (4 - handBob)) % 3);

assert(winner(ROCK, PAPER) == B_WINS);
assert(winner(PAPER, ROCK) == A_WINS);
assert(winner(ROCK, ROCK) == DRAW);

forall(UInt, handAlice =>
    forall(UInt, handBob =>
      assert(isOutcome(winner(handAlice, handBob)));

forall(UInt, (hand) =>
    assert(isOoutcome(winner(handAlice, handBob)))
const Player = {
    ...hasRandom,
    getHand: Fun([], UInt),
    seeOutcome: Fun([UInt], Null),
};

export const main = Reach.App(() =>{
    const Alice = Participant('Alice', {
        ...Player,
        wager: UInt,
        deadline: UInt,
    });
    const Bob = Participant('Bob', {
        ...Player,
        acceptWager: Fun([UInt], Null),
    });
    init();
    
    const informTimeout = () => {
        each([Alice, Bob], () => {
            interact.timeout();
        });
        }
    Alice.only(()=> {
        // const wager = declassify(interact.wager);
        // const _handAlice = interact.getHand();
        // const [_commitAlice, _saltAlice] = makeCommitment(interact, _handAlice);
        // const commitAlice = declassify(_commitAlice)
        const saltAlice = declassify(_saltAlice);
        const handAlice = declassify(_handAlice);
    });

    Alice.publish(wager, commitAlice);
    checkCommitment(commitAlice, saltAlice, handAlice)
    // .pay(interact.wager);
    commit();
    
    unknowable(Bob, Alice(_handAlice, _saltAlice));
    Bob.only(() => {
        interact.acceptWager(wager)
        const handBob = declassify(interact.getHand());
    });
    Bob.publish(handBob)
    .pay(wager);

    const outcome = (handAlice, handBob);
    require(handBob == (HandAlice +1 ) % 3);
    assert(outcome == 0);
    
    const   [forAlice, forBob] =
        outcome == 2? [     2,      0] :
        outcome == 0? [     0,      2] :
        /*tie      */ [     1,      1];
    transfer(forAlice * wager).to(Alice);
    transfer(forBob * wager).to(Bob);
    commit();
    each([Alice, Bob], () => {
        interact.seeOutcome(outcome);
    });
});
