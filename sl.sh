echo search ... $1
grep -e "$1" -nR --color \
	--exclude="*\.svn*" \
	--exclude="*autocode*" \
	--include="*.lua" \
	--include="*.c" \
	--include="*.cpp" \
	--include="*.h" \
	--include "*.hpp" \
	--include "*.pto" \
	--include "*.py" \
	--include "*.go" \
	--include "*.task" \
	*
