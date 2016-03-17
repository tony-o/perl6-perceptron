use Perceptron;
use Trainer;
use Test;

plan 1;

class P does Perceptron['x', 'y'] {
  method activate($result) {
    return 1.Rat;
  }
}

my Trainer @a;
my P $p .=new;
my ($x, $y, $r, $w1, $w2);

for ^2000 {
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
  @a.append(
    Trainer.new(
      :inputs($x, $y), 
      :expected(1)
    )
  );
}


$w1 = $p.weights;
.train($p) for @a;
$w2 = $p.weights;

ok $w1 eqv $w2, 'Weights shouldn\'t change for positive results';

#vi:syntax=perl6
