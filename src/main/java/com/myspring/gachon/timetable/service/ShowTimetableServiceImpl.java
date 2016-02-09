package com.myspring.gachon.timetable.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.timetable.dao.ShowTimetableDao;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

@Service
public class ShowTimetableServiceImpl implements ShowTimetableService {
	@Autowired
	ShowTimetableDao showTimetableDaoImpl;


	@Override
	public List<ShowTimetableVo> selectTimetableinfo(int memberId) {
		return showTimetableDaoImpl.selectTimetableinfo(memberId);
	}

}


