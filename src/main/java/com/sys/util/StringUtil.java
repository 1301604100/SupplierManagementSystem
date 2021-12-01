package com.sys.util;

/**
 * 对字符串进行操作的类
 */
public class StringUtil {

    /**
     * @param str 要判断的字符串
     * @return 判断是否为空
     */
    public static boolean isEmpty(String str) {
        return str == null || "".equals(str);
    }

    /**
     * @param str json字符串
     * @return 要删除的班级id组
     */
    public static int[] getDeleteIdArr(String str) {
        str = str.replace("[", "");
        str = str.replace("]", "");
        String[] idStr = null;
        // 存在逗号就至少有两个数
        if (str.contains(","))
            idStr = str.split(",");
            // 不存在逗号就只有一个数
        else {
            idStr = new String[1];
            idStr[0] = str;
        }
        int[] idArr = new int[idStr.length];
        for (int i = 0; i < idStr.length; i++) {
            idArr[i] = Integer.parseInt(idStr[i]);
        }
        return idArr;
    }
}
