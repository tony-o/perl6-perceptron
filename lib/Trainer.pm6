unit class Trainer;

use Perceptron;

has @.inputs;
has $.expected;
has $.bias = 1;

method train(Perceptron $perceptron) {
  $perceptron.train((|@.inputs, $.bias), $.expected);  
}
