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

$p.perl.say;
.train($p) for @a;
$p.perl.say;

while $y >= (2 * $x) + 1 {
  'change'.say;
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
}
say "$x, $y: { $p.feed($x, $y).Rat } ?= {-1.Rat} { $y } < { (2 * $x) + 1 }";

$r = $p.feed($x, $y);
'ok'.say;
ok "$r" eq "-1.0", 'Negative test';
'/ok'.say;

while $y < (2 * $x) + 1 {
  $x = 250 - 500.rand;
  $y = 250 - 500.rand;
}

say "$x, $y: { $p.feed($x, $y) } ?= 1?";

ok $p.feed($x, $y) == 1, 'Positive test';

done;

#vi:syntax=perl6
