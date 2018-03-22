package com.wangchao.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.wangchao.ssm.mapper.PhotoMapper;
import com.wangchao.ssm.pojo.Photo;
import com.wangchao.ssm.pojo.PhotoDir;
import com.wangchao.ssm.service.PhotoService;

public class PhotoServiceImpl implements PhotoService {
	
	@Autowired
	private PhotoMapper photoMapper;

	@Override
	public int addPhotos(Photo photo) {
		return photoMapper.addPhotos(photo);
	}

	@Override
	public List<PhotoDir> queryMyPhotoDir(int userId) {
		return photoMapper.queryMyPhotoDir(userId);
	}

	@Override
	public List<Photo> queryMyPhotoByDirId(PhotoDir photoDir) {
		return photoMapper.queryMyPhotoByDirId(photoDir);
	}

	@Override
	public int deleteMyPhotoDirByDirId(int photoDirId) {
		return photoMapper.deleteMyPhotoDirByDirId(photoDirId);
	}

	@Override
	public int updateMyPhotoDirNameByDirId(PhotoDir photoDir) {
		return photoMapper.updateMyPhotoDirNameByDirId(photoDir);
	}

	@Override
	public int addPhotoDir(PhotoDir photoDir) {
		return photoMapper.addPhotoDir(photoDir);
	}

	@Override
	public int multiDelPhoto(List<Integer> list) {
		return photoMapper.multiDelPhoto(list);
	}

	@Override
	public int deleteMyPhotoByDirId(int dirId) {
		return photoMapper.deleteMyPhotoByDirId(dirId);
	}
	
	
}
