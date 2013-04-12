require 'formula'

class RakeCompletion < Formula
  homepage 'https://github.com/ai/rake-completion'

  head 'https://github.com/ai/rake-completion.git'

  def install
    bash_completion.install 'rake'
  end
end
