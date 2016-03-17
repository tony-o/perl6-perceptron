unit role Perceptron[*@inputs];

has @.weights;
has $!fixed-input;
has $!bias;
has $!learning-constant;

submethod BUILD (:$!bias = 1, :$!learning-constant = 0.005, :@!weights) {
  if @inputs.elems {
    $!fixed-input = True;
    @!weights.append(1 - 2.rand) for 0..^(@inputs.elems);
  } else {
    $!fixed-input = False;
  }
}

method feed(*@inputs) returns Rat {
  warn 'Results not guaranteed - input length differs from weights'
    if @inputs.elems != @!weights.elems;
  my $r = self.activate([+] ([*] $_ for (@inputs.map({ .Rat }) Z @!weights)));
  $r;
}

method activate($result) returns Rat {
  return 1.0 if $result >= 0;
  -1.0;
}

method train(@inputs, $expected) {
  my $rval  = self.feed(@inputs[0..*-2]);
  my $error = $expected.Rat - $rval;
  @.weights[$_] += $!learning-constant * $error * @inputs[$_] * @inputs[*-1]
    for 0..^(@inputs.elems-1);
  $rval;
}
