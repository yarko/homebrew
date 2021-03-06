require 'formula'

class Hbase < Formula
  homepage 'http://hbase.apache.org'
  url 'http://www.apache.org/dyn/closer.cgi?path=hbase/hbase-0.94.7/hbase-0.94.7.tar.gz'
  sha1 'aaaa857b123731ddc0bfb261e2e672a7d81def91'

  depends_on 'hadoop'

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf docs lib hbase-webapps]
    libexec.install Dir['*.jar']
    bin.write_exec_script Dir["#{libexec}/bin/*"]

    inreplace "#{libexec}/conf/hbase-env.sh",
      "# export JAVA_HOME=/usr/java/jdk1.6.0/",
      "export JAVA_HOME=\"$(/usr/libexec/java_home)\""
  end

  def caveats; <<-EOS.undent
    Requires Java 1.6.0 or greater.

    You must also edit the configs in:
      #{libexec}/conf
    to reflect your environment.

    For more details:
      http://wiki.apache.org/hadoop/Hbase
    EOS
  end
end
