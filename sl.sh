grep -e $1 -nwR --color \
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
	*
