package org.zerock.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class HotelSearchServiceImpl implements HotelSearchService {

	// 경기도 시/군 영문 코드 → 한글 매핑 (header.jsp CITIES와 동일)
	private static final Map<String, String> EN_TO_KO;
	static {
		Map<String, String> m = new HashMap<>();
		m.put("Goyang", "고양");      m.put("Guri", "구리");
		m.put("Namyangju", "남양주"); m.put("Dongducheon", "동두천");
		m.put("Yangju", "양주");      m.put("Uijeongbu", "의정부");
		m.put("Paju", "파주");        m.put("Pocheon", "포천");
		m.put("Gapyeong", "가평");    m.put("Yeoncheon", "연천");
		m.put("Gwacheon", "과천");    m.put("Gwangmyeong", "광명");
		m.put("Gwangju", "광주");     m.put("Gunpo", "군포");
		m.put("Gimpo", "김포");       m.put("Bucheon", "부천");
		m.put("Seongnam", "성남");    m.put("Suwon", "수원");
		m.put("Siheung", "시흥");     m.put("Ansan", "안산");
		m.put("Anseong", "안성");     m.put("Anyang", "안양");
		m.put("Yeoju", "여주");       m.put("Osan", "오산");
		m.put("Yongin", "용인");      m.put("Uiwang", "의왕");
		m.put("Icheon", "이천");      m.put("Pyeongtaek", "평택");
		m.put("Hanam", "하남");       m.put("Hwaseong", "화성");
		m.put("Yangpyeong", "양평");
		EN_TO_KO = m;
	}

	@Setter(onMethod_ =@Autowired)
	private BoardMapper mapper;


	@Override
	public List<SearchVO> listHotels(Map<String, Object> map)  {

		Object raw = map.get("keyword");
		if (raw != null) {
			String keyword = raw.toString().trim();
			String mapped = EN_TO_KO.get(keyword);
			if (mapped != null) {
				map.put("keyword", mapped);
			} else if (keyword.isEmpty()) {
				map.put("keyword", null);
			}
		}

		return mapper.hotelListWithPaging(map);

	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<Map<String, Object>> getPopularRegions(int limit) {
		int clamped = Math.max(1, Math.min(limit, 20));
		List<Map<String, Object>> result = new ArrayList<>(mapper.popularRegions(clamped));

		if (result.size() < clamped) {
			Set<String> seen = new LinkedHashSet<>();
			for (Map<String, Object> row : result) {
				Object s = row.get("state");
				if (s != null) seen.add(s.toString());
			}
			for (Map<String, Object> row : mapper.popularRegionsByHotelCount(clamped)) {
				Object s = row.get("state");
				if (s == null || seen.contains(s.toString())) continue;
				result.add(row);
				seen.add(s.toString());
				if (result.size() >= clamped) break;
			}
		}
		return result;
	}

}
