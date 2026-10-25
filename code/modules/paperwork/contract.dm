/* For employment contracts */

/obj/item/paper/employment_contract
	icon_state = "paper_words"
	throw_range = 3
	throw_speed = 3
	item_flags = NOBLUDGEON
	var/employee_name = ""

/obj/item/paper/employment_contract/Initialize(mapload, new_employee_name)
	if(!new_employee_name)
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	employee_name = new_employee_name
	name = "纸张 - [employee_name] 雇佣合同"
	add_raw_text("雇佣条款</center>\
	<BR><BR><BR><BR>\
	本协议自下方最后签署之日起，由 [employee_name]（以下简称“奴隶”）与 \
	纳米传讯（以下简称“无所不在而乐于助人的人类守望者”）共同订立。\
	<BR>兹证明：<BR>鉴于，奴隶为天生的人类或人形生物，具备可协助无所不在而乐于助人的人类守望者的技能， \
	并希望在无所不在而乐于助人的人类守望者处谋求工作。<BR>鉴于，无所不在而乐于助人的人类守望者同意不定期向奴隶支付报酬， \
	以换取永久劳役。<BR>因此，鉴于本协议所载的相互约定以及其他良好且有价值的对价，双方特此相互约定如下：\
	<BR>作为微薄报酬的交换，奴隶同意为无所不在而乐于助人的人类守望者工作， \
	直至其当前及未来人生的余下岁月。<BR>此外，奴隶同意将其灵魂的所有权转让给无所不在而乐于助人的人类守望者的忠诚部。\
	<BR>若灵魂无法转让，则应改为设定留置权。\
	<BR>签署：<BR><i>[employee_name]</i>")
