function g \
    -d "shorcut for git (runs `git status` if no options given)" \
    -w git # wraps, for completion purposes
  if test (count $argv) -gt 0
      git $argv
  else
      git status --short --branch
  end
end
