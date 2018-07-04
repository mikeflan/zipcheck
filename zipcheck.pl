#
#
# This script checks all the zip files in $dir.
# It prints all the zip files that are not a valid
# zip file.
#
#
use warnings;
use strict;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use File::Find;
Archive::Zip::setErrorHandler( \&myErrorHandler );

#my $dir = 'D:/DDDrive/Maps/AR Topos/1-24 Scale/PDF - 11-2013';
#my $dir = 'D:/DDDrive/Maps/AK Topos';
my $dir = 'D:/DDDrive/Maps/Outside the USA/1-250 Scale';

my $count = 0;
my $num = 0;

print "\n\n";

find sub {
    #NOTE: finddepth chdirs to the directory it's
    #      traversing and sets the filename to $_.
    #      $File::Find::name is the full path to the file
    
    return if -d $_ or -l $_;
    return unless (/\.zip$/i);
    $count++;
    my $zip = Archive::Zip->new();
    unless ($zip->read($_) == AZ_OK) {
	    $num++;
	    print "$File::Find::name is not a valid zip file.\n";
    }
#    $zip->extractMember($_) for $zip->members;
}, $dir;


print "\nAll done.\n\nProcessed $count zip files.\nFound $num files that are invalid zip files.\n\n\n";


sub myErrorHandler {
	# Do nothing upon an error;
}


__END__

