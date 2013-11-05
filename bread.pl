#!/usr/bin/perl
# $Id: bread-builders-calc,v 1.1 2000/08/06 21:51:35 chris Exp $
#
# Calculate flour, water, salt based on independent variables
# of total weight, sponge:total ratio, and hydration bakers percent
# Assumes SpongeHydration = 1.0.

require "getopts.pl";

$TotalWeight		= 1500; # grams for 2x 750g loaves (2x 1.65 pound)
$SpongeTempRatio	= 0.20;	# sponge:total
$TotalHydration		= 0.62;	# baker's percent, 1.00 flour + 0.62 water
$SaltBakersPercent	= 0.02;	# baker's percent: 1.00 flour + 0.02 salt

&Getopts('t:s:h:');

if ($opt_t) {
    $TotalWeight = $opt_t;
}
if ($opt_s) {
    $SpongeTempRatio = $opt_s;
}
if ($opt_h) {
    $TotalHydration = $opt_h;
}
    
print "Ingredients for Dough with a [-t] total weight: $TotalWeight g\n";
print "with temperature-based [-s] sponge ratio: $SpongeTempRatio\n";
print "and flour-protein-based baker's [-h] hydration: $TotalHydration\n";

$TotalFlour = int( 0.5 + $TotalWeight / (1 + $TotalHydration ) );
$TotalWater = $TotalWeight - $TotalFlour;
print "Total   flour, water:  $TotalFlour $TotalWater\n";

$SpongeFlour = int( 0.5 + $TotalWeight * $SpongeTempRatio / 2 );
$SpongeWater = $SpongeFlour;

print "Sponge  flour, water:  $SpongeFlour $SpongeWater\n";

$NewFlour = $TotalFlour - $SpongeFlour;
$NewWater = $TotalWater - $SpongeWater;
print "New     flour, water:  $NewFlour $NewWater\n";

$NewSalt = int(0.5 + $TotalFlour * $SaltBakersPercent);
print "New             salt:            $NewSalt\n";

# If I want 300g sponge + 300g to re-Store, need 600g
# with first 5x expansion then a 3x expansion

$OrigStorageLeaven = 2 * ($SpongeFlour + $SpongeWater) / ( 5 * 3 );
print "StorageLeaven from Fridge: $OrigStorageLeaven\n";

print <<EOT;

    You want to start with a Storage Leaven then 5x then 3x
    and this should give you twice as much as you need
    so you can put half back in the Fridge.
EOT

exit(0);


