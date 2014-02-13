require 'formula'

class Winbugs < Formula
  homepage 'http://www.mrc-bsu.cam.ac.uk/bugs/winbugs/contents.shtml'
  url 'http://www.mrc-bsu.cam.ac.uk/bugs/winbugs/winbugs14.zip'
  sha1 '8a7c9e548f1680b15edf7b9964bb27c95326db0f'

  depends_on 'wine'
  depends_on :x11

  def install
    exe = File.new('WinBUGS14', 'w')
    exe << "wine '#{libexec}/WinBUGS14.exe' $@"
    exe.chmod(0777)
    exe.close
    libexec.install Dir['*']
    bin.mkpath
    bin.install_symlink '../libexec/WinBUGS14' => 'WinBUGS14'
    
    curl '-O', 'http://www.mrc-bsu.cam.ac.uk/bugs/winbugs/WinBUGS14_cumulative_patch_No3_06_08_07_RELEASE.txt'
    curl '-O', 'http://www.mrc-bsu.cam.ac.uk/bugs/winbugs/WinBUGS14_immortality_key.txt'
    etc.install Dir["WinBUGS14_*.txt"]
  end

  def caveats; <<-EOS.undent
     o WinBUGS14 requires the manual application of a patch, execute:
       WinBUGS14 #{etc}/WinBUGS14_cumulative_patch_No3_06_08_07_RELEASE.txt
     
     o Next, you need to load the inmortality key, execute:
       WinBUGS14 #{etc}/WinBUGS14_immortality_key.txt
     
     o To open WinBUGS, execute `WinBUGS` in the terminal.
     EOS
  end

  test do
    system "#{bin}/WinBUGS14"
  end
end
