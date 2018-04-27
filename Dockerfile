From centos:7

MAINTAINER Bezeklik

RUN yum --assumeyes install \
        httpd \
        "perl(Image::Magick)" \
        "perl(Digest::MD5)" \
        "perl(Mozilla::CA)" \
        "perl(Archive::Zip)" \
        "perl(Archive::Tar)" \
        "perl(XML::LibXML::SAX)" && \
    sed -i.org '/#AddHandler cgi-script/s/#//' /etc/httpd/conf/httpd.conf && \
    curl -LO https://github.com/movabletype/movabletype/archive/mt6.3.7-1.tar.gz && \
    restorecon -R /var/www/cgi-bin  && \
    ln -s /var/www/cgi-bin/mt/mt-static /var/www/html/  && \
    chcon -t httpd_sys_content_rw_t /var/www/{html,cgi-bin/{mt,mt/mt-static/support}}  && \
    chown apache:apache /var/www/{html,cgi-bin/{mt,mt/mt-static/support}}
#    chmod -R 755 /var/www/html

EXPOSE 80

CMD ["httpd", "-DFOREGROUND"]
