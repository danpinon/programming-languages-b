/*
1. Write a function sequence that takes 3 arguments low, high, and stride, all assumed to be numbers.
Further assume stride is positive. sequence produces a list of numbers from low to high (including
low and possibly high) separated by stride and in sorted order.
*/

//1.
function sequence({ low, high, stride }) {
  if (low > high) return [];
  return [low, ...sequence({ low: low + stride, high, stride })];
}

console.log(sequence({ low: 3, high: 11, stride: 2 }));

//4.
function streamsForNSteps(stream, n) {
  const f = (stream, n, acc) => {
    const [value, nextStream] = stream();
    if (n === 0) {
      return acc;
    }
    return f(nextStream, n - 1, [...acc, value]);
  };
  return f(stream, n, []);
}
//6.
function danThenDog() {
  const f = (n) => {
    return [n === 0 ? "dan.jpg" : "dog.jpg", () => f((n + 1) % 2)];
  };
  return f(0);
}
