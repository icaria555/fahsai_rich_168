# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative('th_location')

def create_roles
	Role.create([
		{name: 'admin', 			level: 1},
		{name: 'employee', 		level: 2},
		{name: 'wholesaler', 	level: 3},
		{name: 'mobile', 			level: 4},
		{name: 'member', 			level: 5}
	])
	puts 'create roles success!'
end

def create_province(name)
	Province.create(name: name)
end

def create_amphur(name, province)
	Amphur.create(name: name, province: province)
end

def create_district(name, amphur, latitude, longitude)
	District.create(name: name, amphur: amphur, latitude: latitude, longitude: longitude)
end

def create_or_find_zipcode(code)
	zipcode = Zipcode.find_by_code(code)
	if zipcode.nil?
		return Zipcode.create(code: code)
	else
		return zipcode
	end
end

def create_district_zipcode(district, zipcode)
	DistrictZipcode.create(district: district, zipcode: zipcode)
end

def create_th_location
	provinces = th_location()
	count = 0
	provinces.each do |province, amphurs|
		province = create_province(province)
		amphurs.each do |amphur, districts|
			amphur = create_amphur(amphur, province)
			districts.each do |district, data|
				district = create_district(district, amphur, data[:latitude], data[:longitude])
				data[:zipcode].each do |zipcode|
					zipcode = create_or_find_zipcode(zipcode)
					create_district_zipcode(district, zipcode)
				end
			end
		end
		count += 1
		puts "create Province #{count}/77 #{(count/77.0*100.0).round(2)}%"
	end
end

def create_user
	province = Province.first
	amphur = province.amphurs.first
	district = amphur.districts.first
	zipcode = district.zipcodes.first
	user = User.create(
		email: "o_k_t@hotmail.com",
		password: "password",
		iden_number: "1102001936122",
		first_name: "Tatchagon",
		last_name: "Koonkoei",
		address: "111/1 ม.3",
		district: district,
		amphur: amphur,
		province: province,
		zipcode: zipcode,
		phone_number: "0826810461",
		line_id: "tachagon",
		birthday: "06/02/1993",
		gender: "male"
		)
	puts "create user success!"
	
end

create_roles()
create_th_location()
create_user()
