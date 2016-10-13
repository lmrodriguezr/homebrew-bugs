
class Winbugs < Formula
  desc "The BUGS (Bayesian inference Using Gibbs Sampling) project."
  homepage "http://www.mrc-bsu.cam.ac.uk/software/bugs/"
  url "http://www.mrc-bsu.cam.ac.uk/wp-content/uploads/winbugs14_unrestricted.zip"
  version "1.4.3"
  sha256 "f9aa7dc922e991c82b131599ce6aa7f92913d3891c5f05d606ef361a29d198de"

  depends_on "wine"
  depends_on :x11

  def install
    exe = File.new("WinBUGS14", "w")
    exe << "wine '#{libexec}/WinBUGS14.exe' $@"
    exe.chmod(0777)
    exe.close
    libexec.install Dir["*"]
    bin.mkpath
    bin.install_symlink "../libexec/WinBUGS14" => "WinBUGS14"
    curl "-O", "http://www.mrc-bsu.cam.ac.uk/wp-content/uploads/WinBUGS14_cumulative_patch_No3_06_08_07_RELEASE.txt"
    curl "-O", "http://www.mrc-bsu.cam.ac.uk/wp-content/uploads/WinBUGS14_immortality_key.txt"
    etc.install Dir["WinBUGS14_*.txt"]
  end

  def caveats; <<-EOS.undent
     o WinBUGS14 requires the manual application of a patch, execute:
       WinBUGS14 #{etc}/WinBUGS14_cumulative_patch_No3_06_08_07_RELEASE.txt
     o Next, you need to load the inmortality key, execute:
       WinBUGS14 #{etc}/WinBUGS14_immortality_key.txt
     o To open WinBUGS, execute `WinBUGS14` in the terminal.
     EOS
  end

  test do
    system "#{bin}/WinBUGS14"
  end
end
