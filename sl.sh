grep -e $1 -nR --exclude="*\.svn*" --exclude="*autocode*" --include="*\.lua" --include="*\.c" --include="*\.cpp" --include="*\.h" --include "*\.hpp"  --include "*\.pto" * --color
