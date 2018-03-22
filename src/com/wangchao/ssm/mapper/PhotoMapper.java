package com.wangchao.ssm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wangchao.ssm.pojo.Photo;
import com.wangchao.ssm.pojo.PhotoDir;

public interface PhotoMapper {

	int addPhotos(@Param(value="photo")Photo photo);


	List<Photo> queryMyPhotoByDirId(PhotoDir photoDir);
	
	
	//相册增删改查

	List<PhotoDir> queryMyPhotoDir(@Param(value="userId")int userId);
	
	int deleteMyPhotoDirByDirId(int photoDirId);
	
	int updateMyPhotoDirNameByDirId(PhotoDir photoDir);

	int addPhotoDir(PhotoDir photoDir);

	//批量删除我的照片
	int multiDelPhoto(@Param("list")List<Integer> list);

	//删除指定相册下所有照片
	int deleteMyPhotoByDirId(@Param("dirId")int dirId);
}
