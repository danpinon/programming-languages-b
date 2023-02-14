function f(x) {
      return [x, () => f(x + 1)]
}
function streamF() {
      return f(1)
}

const numberUntil = (stream, tester) => {
      function f (stream, ans) {
               let [value, nextStream] = stream(); // or let pair = stream();
                    if ( tester(value) ) return ans;
                         return f(nextStream, ans + 1);
                           }
                             return f(stream, 1);
}

console.log(numberUntil(streamF, isSixTester ))

function isSixTester(x) {
      return x === 6
}
