class_name TestController extends Node

## 遍历检测TF翻译文件
func Test_all_TF():
    Ui.add_test("开始测试翻译文件")
    
    for it in Data.TF_files:
        
        ##### 检索 内容中 标记数量
        var mark_num=it.content.countn(Data.mark)
        if mark_num==0:
            Ui.add_test("错误："+it.file_name+"中的标记数为0。")
            Data.is_err=true
            return 1
        if mark_num % 3 !=0:
            Ui.add_test("错误："+it.file_name+"中的标记数不能被3整除。")
            Data.is_err=true
            return 1
        
        
        if !TL_flow_obj_in_test(it): ## 反包含验证
            Ui.add_test("错误："+it.file_name+"文件反包含：")
            Data.is_err=true
            return 1  ## 反向包含将退出
        
        var source=Data.find_SF(it) ## 找到匹配的原文件
        
        #if source==null:
            # Ui.add_test("错误："+"存在无法找到与之对应的源文件的翻译文件。")
            
        var TL_S=it.get_TL_entrys()
        
        ##### 检索文件内容的存在性。如选项。
        if Data.is_identically:
            for op in TL_S:
                if source.content.find(op.source_text)==-1:
                    Ui.add_test("错误：\n"+op.source_text+"\n"+it.file_name+"源内容不存在\n")
                # Ui.add_test("错误：\n"+op.translation_text+"\n"+it.file_name+"源内容不存在\n")
                    Data.is_err=true
                    return 1  ## 反向包含将退出
    Ui.add_test("\n测试通过\n")
    return 0

## _TLL 为词条组
## file 为包含词条的文件。
## 验证词条的反包含性,即验证较短词条是否重复替代较长词条翻译后的结果。
func TL_flow_obj_in_test(file):
    ## 查找同名文件
    var files=Data.find_ename_TF(file)
    
    var _TLL=[]
    for tiem in files:
        _TLL.append_array(tiem.get_TL_entrys())
    
    for op in _TLL:
        if op.translation_text=="" : # or op.translation_text=="\n"
            print(op.translation_text)
            op.translation_text=op.source_text
            #var str_:String=Ui.get_text()
            #Ui.show_text(str_+str(op))
    
    var length=_TLL.size()-1
    if length==-1:
        return true
    
    var is_pass=true
    while length>=0:
        for u in range(length):
            if _TLL[u].translation_text.find(_TLL[length].source_text)!=-1:
                is_pass=false
                Ui.add_test("该词条反包含：\n"+"原文:"+_TLL[length].source_text+"\n译文\n"+_TLL[length].translation_text)
            pass
        length-=1
    return is_pass
