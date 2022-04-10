#!/bin/bash
# Git configuration
mkdir -p ~/git/
cd ~/git/
if [ $? = "0" ]; then
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/utilities.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/aws-terraform.git
    git lfs clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/terraform.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/solrcloud-config.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/Jenkinsfiles.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/varnish-configuration.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/httpd-configuration.git
    mkdir -p xalok; cd xalok
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/xalok/image-building.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/xalok/rcs-corriere.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/xalok/rcs-gazzetta.git
    git     clone https://repoGitlab:$gitRcsToken@gitlab.rcslan.it/CDT/xalok/rcs-provision.git
    cd ..
else
 echo "Problem with folder creation"
fi

# SVN configuration
mkdir -p ~/svn/
cd ~/svn/
if [ $? = "0" ]; then
    svn co http://svn.farm-rcs.it/repos/ApacheAzure/
    svn co http://svn.farm-rcs.it/repos/DNS
    svn co http://svn.farm-rcs.it/repos/Wordpress/
    svn co http://svn.farm-rcs.it/repos/VarnishAzure/
    svn co http://svn.farm-rcs.it/repos/puppet/branches/current/puppet
    svn co http://svn.farm-rcs.it/repos/TomcatAzure
else
 echo "Problem with folder creation"
fi

# GKE configuration
gcloud init
clusters=$(gcloud container clusters list | grep -vE 'NAME.*LOCATION' | awk '{print $1}') 
for cluster in $clusters; do 
   gcloud container clusters get-credentials $cluster --region europe-west4 --project prod-268013
done 
