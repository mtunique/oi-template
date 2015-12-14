class Solution(object):
    def simplifyPath(self, path):
        """
        :type path: str
        :rtype: str
        """
        path_list = path.split('/')
        rst_list = []
        for item in path_list:
            if item:
                if item == r'.':
                    continue
                if item == r'..':
                    if rst_list:
                        rst_list.pop()
                else:
                    rst_list.append(item)

        return '/'+'/'.join(rst_list)

if __name__ == "__main__":
    print Solution().simplifyPath('/home//foo/')

