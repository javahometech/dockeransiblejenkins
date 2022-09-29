# dockeransiblejenkins<br>

To run this pipeline below requirements has to be fullfilled<br>

Installed VM<br>
OS: CentOS 7.9<br>

Installed Softwares<br>

Jenkins: jenkins-2.361.1-1.1.noarch From "jenkins"<br>
cat /etc/yum.repos.d/jenkins.repo<br>
[jenkins]<br>
name=Jenkins-stable<br>
baseurl=http://pkg.jenkins.io/redhat-stable<br>
gpgcheck=1<br>

ansible 2.9.27 From "epel"<br>
cat /etc/yum.repos.d/epel.repo<br>
[epel]<br>
name=Extra Packages for Enterprise Linux 7 - $basearch<br>
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch<br>
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch<br>
failovermethod=priority<br>
enabled=1<br>
gpgcheck=1<br>
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7<br>

Docker version 1.13.1 From "extras"<br>

Enabled Repositories<br>
base/7/x86_64                                               CentOS-7 - Base                               <br>
epel/x86_64                                                 Extra Packages for Enterprise Linux 7 - x86_64<br>
extras/7/x86_64                                             CentOS-7 - Extras                             <br>
jenkins                                                     Jenkins-stable                                <br>
updates/7/x86_64                                            CentOS-7 - Updates                            <br>
