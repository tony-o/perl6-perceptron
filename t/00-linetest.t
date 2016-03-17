use Perceptron;
use Trainer;
use Test;

plan 2;

my Trainer @a;
my Perceptron['x','y'] $p .=new;
my ($x, $y, $r);

for ^2000 {
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
  @a.append(
    Trainer.new(
      :inputs($x, $y), 
      :expected($y < (2*$x)+1 ?? 1 !! -1)
    ));
}

.train($p) for @a;

while $y < (2 * $x) + 1 {
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
}

$r = $p.feed($x, $y);
ok $r == -1.0, 'Negative test';

while $y >= (2 * $x) + 1 {
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
}

ok $p.feed($x, $y) == 1.0, 'Positive test';

#vi:syntax=perl6
