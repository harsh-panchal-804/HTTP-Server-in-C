#ifndef FS_H
#define FS_H

#include<linux/limits.h>
#include "stringops.h"
#include<sys/stat.h>
typedef struct{

    bool exists;
    size_t size;

}fs_metadata;


fs_metadata fs_get_metadata(string filename){
    char buf[PATH_MAX]; ///4kb
    struct stat st;
    fs_metadata metadata;
    metadata.exists=false;
    if(filename.len> PATH_MAX)return metadata;
    memset(buf,0,sizeof(buf));
    memcpy(buf,filename.data,filename.len);
    if(stat(buf,&st)<0){
        return metadata;
    }
    metadata.size=st.st_size;
    metadata.exists=true;
    return metadata;

}
#endif /* FS_H */