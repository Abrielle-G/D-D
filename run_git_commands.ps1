Set-Location 'c:\Users\LuAnstrm\Desktop\agents\D-D'

Write-Host "=== GIT STATUS ===" -ForegroundColor Cyan
git status

Write-Host "`n=== GIT REMOTE -V ===" -ForegroundColor Cyan
git remote -v

Write-Host "`n=== GIT ADD -A ===" -ForegroundColor Cyan
git add -A
Write-Host "Files staged successfully."

Write-Host "`n=== GIT COMMIT ===" -ForegroundColor Cyan
git commit -m @"
Add project files

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
"@

Write-Host "`n=== GIT PUSH ===" -ForegroundColor Cyan
git push

Write-Host "`n=== COMPLETED ===" -ForegroundColor Green
