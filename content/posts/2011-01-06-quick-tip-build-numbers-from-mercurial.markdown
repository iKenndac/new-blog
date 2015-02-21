---
kind: article
author: Daniel Kennett
created_at: '2011-01-06 14:14:17'
layout: post
slug: quick-tip-build-numbers-from-mercurial
status: publish
title: 'Quick Tip: Build numbers from Mercurial'
wordpress_id: '685'
categories:
- Programming-Work
---

<p>All of my applications these days are versioned after the revision number of the version control repository they're built from. Normally, having a version number different from the human readable version number isn't necessary, but it's handy in some cases, such as distributing beta builds and managing multiple builds of the same version.</p>

<img src="/pictures/for_posts/2011/01/ClarusAbout.png" width="364" height="414" />
{:.left .no-border}

<p>For example, to the left you can see Clarus version 1.5.4 (239), which is the version you can download from my <a href="http://www.kennettnet.co.uk/products/clarus/">website</a>. The version submitted to the Mac App Store is 1.5.4 (247) for a couple of reasons:</p>
<ul>
<li>If you're distributing apps both in and out of the App Store, you want the human-readable version number to be the same in both so users don't feel the version in the App Store (or not) is "newer" than their version.</li>
<li>It's handy for easily identifying App Store copies of your app with a simple "What version do you have?" question, just in case the App Store build has a unique issue.</li>
<li>The <em>only</em> changes between the builds are App Store related - no functionality changes at all.</li>
</ul>
<p>This build number is inserted into the CFBundleVersion key in the application's Info.plist automatically by a build script. It's based on <a href="http://www.mcubedsw.com/blog/index.php/site/comments/build_numbers_from_bazaar/">a script by Martin Pilkington</a> that does a similar thing for the Bazaar VCS, but with a few differences:</p>
<ul>
<li>It uses Mercurial rather than Bazaar.</li>
<li>It doesn't use the presence of a .hg directory to determine whether the project is under version control or not, since this breaks if your Xcode project isn't at the root level of the repository. </li>
</ul>
<p>And, most importantly in my eyes:</p>
<ul>
<li>It modifies the Info.plist file inside the built application rather than the one in your project. This minor difference means you don't get an unclean repository by building the application.</li>
</ul>
<p>To use the script, right-click your Target in Xcode and choose Add &gt; New Build Phase &gt; New Run Script Build Phase. Set the new script to use the /usr/bin/perl shell, and paste in the script below. Enjoy!</p>

~~~~~~~~ perl
#Check if we're versioned under hg
my $revno = `/usr/local/bin/hg id -n`;

if ($revno && $revno !~ m/abort/i) {

	print("Revision number is " . $revno);

    #get the revno minus the new line
    $revno =~ tr/+//d;
    substr($revno, -1, 1, "");
    #open the info plist
    open(my $input,  "< ",  "$ENV{BUILT_PRODUCTS_DIR}/$ENV{INFOPLIST_PATH}")  or die "Can't open Info.plist: $!";
    my $outputstring = "";
    
    #loop through each line until we find CFBundleVersion, then substitute the next line
    while (+<$input>) {
        $outputstring .= "$_";
        if (/[\t ]+<key>CFBundleVersion< \/key>\n/) {
            my $line = +< $input>;
            $line =~ s/([\t ]+<string>)(.*?)(< \/string>)/$1.($revno).$3/eg;
            $outputstring .= $line;
        }
    }
    
    #write back out to Info.plist
    open(my $output,  ">",  "$ENV{BUILT_PRODUCTS_DIR}/$ENV{INFOPLIST_PATH}")  or die "Can't open Info.plist: $!";
    print $output $outputstring;
} else {
    print "This project is not versioned";
}
~~~~~~~~