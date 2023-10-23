#include "../include/libft.h"
#include <stdlib.h>

char *ft_substr(char const *s, unsigned int start, size_t len)
{
	char *substr;
	char *startsubstr;

	if (!s) 
		return ((char *)0);
	if (start >= ft_strlen(s))
	{
		substr = (char *) malloc(1);
		substr[1] = '\0';
		return (substr);
	}
	if (ft_strlen(&s[start]) >= len)
		substr = (char *) malloc(len + 1);
	else
		substr = (char *) malloc(ft_strlen(&s[start]) + 1);
	if (!substr)
		return ((char *) 0);
	startsubstr  = substr;
	while (s[start] && (len-- > 0))
	{
		*substr = s[start++];
		substr++;
	}
	return (startsubstr);
}
