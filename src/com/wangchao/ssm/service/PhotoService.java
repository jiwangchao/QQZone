package com.wangchao.ssm.service;

import java.util.List;

import com.wangchao.ssm.pojo.Photo;
import com.wangchao.ssm.pojo.PhotoDir;

/**
 * @author 吉王超
 * @date 2017年5月13日 下午4:27:42
 * @Description 上传照片到相册
 */
public interface PhotoService {

	/**
	 * 上传图片
	 */
	int addPhotos(Photo photo);

	/**
	 * 查看我的相册
	 */
	List<PhotoDir> queryMyPhotoDir(int userId);
	/**
	 * 打开指定相册的图片
	 */
	List<Photo> queryMyPhotoByDirId(PhotoDir photoDir);
	/**
	 * 添加相册
	 */
	int addPhotoDir(PhotoDir photoDir);
	/**
	 *删除相册 
	 */
	int deleteMyPhotoDirByDirId(int photoDirId);
	/**
	 * 修改相册名称
	 */
	int updateMyPhotoDirNameByDirId(PhotoDir photoDir);
	/**
	 * 批量删除我的照片
	 */
	int multiDelPhoto(List<Integer> list);
	/**
	 * 删除知道相册下所有照片
	 */
	int deleteMyPhotoByDirId(int dirId);
	
}
