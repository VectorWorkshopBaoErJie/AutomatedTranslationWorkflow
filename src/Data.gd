## 这是项目的数据库，这里进行了简化，将项目配置也归并到这里了。
extends Node

var is_err=false

## 待翻译的原文件 组
var SF_files=[]

## 翻译库文件 组
var TF_files=[]

const path_doc_cn=["Doc_cn/V1"]
const path_doc_source="Doc_source/V1"

const is_identically=false

## 以下是项目的配置
var DOC_path=G.dir_current_parent()+path_doc_source
# var DOC_cn_path=[G.dir_current_parent()+path_doc_cn[0],G.dir_current_parent()+path_doc_cn[1]]
var DOC_cn_path=[G.dir_current_parent()+path_doc_cn[0]]

## 待翻译的文件类型
var tr_type=["md"]
var mark="{==+==}"

## 通过指定已翻译文件找到对应的待翻译文件
func find_SF(tf:TF):
    for it in Data.SF_files:
        var na1=tf.file_name.replace("_cn.md",".md")
        
        for path in DOC_cn_path:
            var na2=tf.path.replace(path,path_doc_source)
            if it.file_name==na1 and it.path==na2:
                return it
    return null

## 通过指定待翻译文件找到对应的已翻译文件
func find_TF(tf:SF)->Array:
    var files=[]
    var na1=tf.file_name.replace(".md","_cn.md")
    
    for it in Data.TF_files:
        for _path in path_doc_cn:  
             
            var na2=tf.path.replace(path_doc_source,_path)
            
            if it.file_name==na1 and it.path==na2:
                files.append(it)      
    return files

## 查找同名翻译文件
func find_ename_TF(file):
    var file_paths=[]
    for item in path_doc_cn:
        for op in TF_files:
            if op.path==G.dir_current_parent()+path_doc_cn[0]+"/"+file.file_name:
                file_paths.append(op)
    return file_paths
