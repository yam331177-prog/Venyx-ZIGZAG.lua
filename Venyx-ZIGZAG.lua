--==================================================================
-- VENYX STEAL AN EGG • THAI UI BY ZIGZAG • V1.8
-- Teleport persistence for V1.7: UI translations only after server hop.
-- Proven V1.7 payload below is EXACTLY unchanged, including Steal Panel.
-- Queues one translator per hop; NEVER queues the external Venyx loader.
-- Gameplay / movement / toggles / saved settings are not modified.
-- Requires executor queue_on_teleport or executor Auto Execute fallback.
--==================================================================
local HOP_RUN = false
local CORE = [=[--==============================================================
-- VENYX STEAL AN EGG • THAI UI BY ZIGZAG • V1.7 (V1.6 + RIGHT-SIDE STEAL PANEL THAI UI)
-- Translation overlay only; external Venyx loader kept unchanged.
-- Only updates UI Text/PlaceholderText in detected Venyx/Steal Panel GUI.
-- Does not change steal/farm logic, character movement, or settings.
-- This file DOES NOT contain decrypted/protected Venyx source.
--==============================================================
local ENV = (type(getgenv) == "function" and getgenv()) or _G
local OLD = ENV.__ZIGZAG_VENYX_THAI_STATE
local HAD_LOADER = OLD and OLD.LoaderStarted
if OLD and type(OLD.Stop) == "function" then
    pcall(OLD.Stop)
end

local STATE = {
    Running = true,
    Connections = {},
    Observed = setmetatable({}, {__mode = "k"}),
    Roots = setmetatable({}, {__mode = "k"}),
    Busy = setmetatable({}, {__mode = "k"}),
    LoaderStarted = HAD_LOADER or false,
    Count = 0,
}
ENV.__ZIGZAG_VENYX_THAI_STATE = STATE
local function bind(conn)
    if conn then table.insert(STATE.Connections, conn) end
    return conn
end
function STATE.Stop()
    STATE.Running = false
    for _,conn in ipairs(STATE.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(STATE.Connections)
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local SOURCE_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"

-- Translations below come from all supplied Venyx v1.0.2 screenshots.
-- V1.3 translates visible option names (rarities, zones, racers, shop items)
-- only as GUI text; the game's actual option handlers/data are untouched.
local TH = {
    ["aa"] = "กิจกรรมแอดมิน",
    ["active"] = "กำลังใช้งาน",
    ["admin abuse"] = "กิจกรรมแอดมิน",
    ["after stealing a match"] = "หลังขโมยไข่ที่ตรงเงื่อนไข",
    ["all"] = "ทั้งหมด",
    ["all picked rules"] = "ตรงทุกเงื่อนไขที่เลือก",
    ["always"] = "ตลอดเวลา",
    ["anti guard"] = "หลบหลีกยาม",
    ["any picked rule"] = "ตรงอย่างน้อยหนึ่งเงื่อนไข",
    ["apply"] = "นำไปใช้",
    ["auto"] = "อัตโนมัติ",
    ["auto butterfly"] = "ทำผีเสื้ออัตโนมัติ",
    ["auto buy nitro"] = "ซื้อ Nitro อัตโนมัติ",
    ["auto buy shop"] = "ซื้อของในร้านอัตโนมัติ",
    ["auto buy trails"] = "ซื้อรอยเท้าอัตโนมัติ",
    ["auto catch shooting star"] = "จับดาวตกอัตโนมัติ",
    ["auto claim index rewards"] = "รับรางวัลสมุดอัตโนมัติ",
    ["auto claim offline cash"] = "รับเงินออฟไลน์อัตโนมัติ",
    ["auto claim rewards"] = "รับรางวัลอัตโนมัติ",
    ["auto equip"] = "สวมใส่อัตโนมัติ",
    ["auto equip racer"] = "เลือกตัวแข่งให้อัตโนมัติ",
    ["auto favorite"] = "เพิ่มรายการโปรดอัตโนมัติ",
    ["auto fuse"] = "ผสมอัตโนมัติ",
    ["auto hatch"] = "ฟักไข่อัตโนมัติ",
    ["auto hop"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto hop server"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto if empty"] = "สร้างชื่ออัตโนมัติหากเว้นว่าง",
    ["auto load"] = "โหลดอัตโนมัติ",
    ["auto load script"] = "โหลดสคริปต์อัตโนมัติ",
    ["auto mutate"] = "กลายพันธุ์อัตโนมัติ",
    ["auto place"] = "วางไข่อัตโนมัติ",
    ["auto race"] = "แข่งวิ่งอัตโนมัติ",
    ["auto save"] = "บันทึกอัตโนมัติ",
    ["auto sell eggs"] = "ขายไข่อัตโนมัติ",
    ["auto sell lab eggs"] = "ขายไข่แล็บอัตโนมัติ",
    ["auto sell pets"] = "ขายสัตว์เลี้ยงอัตโนมัติ",
    ["auto steal"] = "ขโมยไข่อัตโนมัติ",
    ["auto treadmill"] = "วิ่งลู่อัตโนมัติ",
    ["auto upgrade base"] = "อัปเกรดฐานอัตโนมัติ",
    ["auto upgrade treadmill"] = "เพิ่มระดับลู่อัตโนมัติ",
    ["background color"] = "สีพื้นหลัง",
    ["bar size"] = "ขนาดแถบปุ่มลัด",
    ["bases"] = "ฐานผู้เล่น",
    ["best"] = "ดีที่สุด",
    ["best mutation"] = "การกลายพันธุ์ดีที่สุด",
    ["best owned"] = "ตัวที่มีดีที่สุด",
    ["best rarity"] = "หายากที่สุด",
    ["best steal"] = "ไข่ที่ดีที่สุด",
    ["best value"] = "มูลค่าสูงสุด",
    ["biggest"] = "ตัวใหญ่ที่สุด",
    ["butterfly"] = "ผีเสื้อ",
    ["butterfly bloom"] = "ผีเสื้อผลิบาน",
    ["butterfly event"] = "กิจกรรมผีเสื้อ",
    ["butterfly machine"] = "เครื่องผีเสื้อ",
    ["buy"] = "ซื้อ",
    ["calculate mutations"] = "คำนวณผลจากการกลายพันธุ์",
    ["cancel"] = "ยกเลิก",
    ["cancel selection"] = "ยกเลิกการเลือก",
    ["cards show the value with these mutations added"] = "การ์ดแสดงมูลค่าหลังรวมการกลายพันธุ์ที่เลือก",
    ["cash"] = "เงินสด",
    ["catch"] = "จับดาว",
    ["caught"] = "จับได้แล้ว",
    ["change if steal fails"] = "ปรับเมื่อขโมยไม่สำเร็จ",
    ["chilli hub"] = "Chilli Hub",
    ["claim"] = "รับ",
    ["clear"] = "ล้าง",
    ["clear all keybinds"] = "ล้างปุ่มลัดคีย์บอร์ดทั้งหมด",
    ["clear all quick bars"] = "ล้างแถบปุ่มลัดทั้งหมด",
    ["close"] = "ปิด",
    ["closest"] = "ใกล้ที่สุด",
    ["common"] = "ทั่วไป",
    ["config"] = "ตั้งค่าโปรไฟล์",
    ["configuration"] = "การตั้งค่า",
    ["confirm"] = "ยืนยัน",
    ["copy"] = "คัดลอก",
    ["copy invite"] = "คัดลอกลิงก์เชิญ",
    ["copy job id"] = "คัดลอก Job ID",
    ["create"] = "สร้าง",
    ["create config"] = "สร้างโปรไฟล์",
    ["credits"] = "เครดิต",
    ["default"] = "ค่าเริ่มต้น",
    ["default config"] = "โปรไฟล์เริ่มต้น",
    ["delete"] = "ลบ",
    ["delete picked"] = "ลบโปรไฟล์ที่เลือก",
    ["delivering"] = "กำลังนำไข่กลับ",
    ["delivery speed"] = "ความเร็วในการนำไข่กลับ",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["deselect all"] = "ยกเลิกทั้งหมด",
    ["dim the game"] = "ลดความสว่างเกม",
    ["disable 3d render"] = "ปิดการแสดงผลภาพ 3 มิติ",
    ["disabled"] = "ปิดการใช้งาน",
    ["discord"] = "ดิสคอร์ด",
    ["discord role id"] = "ID ยศ Discord",
    ["discord user id"] = "ID ผู้ใช้ Discord",
    ["discord webhook"] = "เว็บฮุก Discord",
    ["distance"] = "ระยะทาง",
    ["divine"] = "เทพเจ้า",
    ["doing"] = "กำลังทำ",
    ["done"] = "เสร็จแล้ว",
    ["dr. scramble"] = "Dr. Scramble",
    ["dr. scramble lab"] = "แล็บ Dr. Scramble",
    ["drop eggs at safe zone"] = "วางไข่ในเขตปลอดภัย",
    ["duration"] = "ระยะเวลา",
    ["egg"] = "ไข่",
    ["egg bag"] = "กระเป๋าไข่",
    ["egg predictor"] = "คาดการณ์ไข่",
    ["egg showcase"] = "แสดงรายการไข่",
    ["eggs"] = "ไข่",
    ["eject odd pets"] = "นำสัตว์เลี้ยงที่เกินออก",
    ["enabled"] = "เปิดการใช้งาน",
    ["enchanted"] = "ต้องมนตร์",
    ["enchanted forest"] = "ป่ามนตร์",
    ["epic"] = "มหากาพย์",
    ["equip best pets"] = "ใส่สัตว์เลี้ยงที่ดีที่สุด",
    ["error"] = "ข้อผิดพลาด",
    ["eternal"] = "นิรันดร์",
    ["event"] = "กิจกรรม",
    ["expires in"] = "หมดเวลาในอีก",
    ["export config"] = "ส่งออกโปรไฟล์",
    ["failed"] = "ไม่สำเร็จ",
    ["farm"] = "ฟาร์ม",
    ["fast tween to egg"] = "เคลื่อนที่แบบ Tween ไปหาไข่อย่างรวดเร็ว",
    ["favorite"] = "รายการโปรด",
    ["filter"] = "ตัวกรอง",
    ["find an option"] = "ค้นหาตัวเลือก",
    ["first"] = "อันดับแรก",
    ["first hop after"] = "เริ่มย้ายครั้งแรกหลัง",
    ["fix"] = "แก้ไข",
    ["fixed lag back with the tween delivery method"] = "แก้อาการแลคตอนกลับด้วยวิธีส่งแบบ Tween",
    ["fps cap"] = "จำกัด FPS",
    ["fractured"] = "แตกร้าว",
    ["frame rate"] = "อัตราเฟรม",
    ["fuse"] = "ผสม",
    ["fuse filter"] = "ตัวกรองการผสม",
    ["fuse first"] = "เลือกผสมก่อน",
    ["fuse machine"] = "เครื่องผสม",
    ["fuse predictor"] = "คาดการณ์การผสม",
    ["go to egg"] = "วิธีไปหาไข่",
    ["graphics"] = "กราฟิก",
    ["growing"] = "กำลังเติบโต",
    ["hatched"] = "ฟักแล้ว",
    ["hatching"] = "กำลังฟักไข่",
    ["hide game ui"] = "ซ่อนหน้าต่างของเกม",
    ["hide my pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของฉัน",
    ["hide other players' pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของผู้เล่นอื่น",
    ["high"] = "สูง",
    ["highest rarity"] = "หายากที่สุด",
    ["highest value first"] = "มูลค่าสูงสุดก่อน",
    ["home"] = "หน้าแรก",
    ["hop server"] = "ย้ายเซิร์ฟเวอร์",
    ["hop to"] = "ย้ายไปเซิร์ฟเวอร์แบบ",
    ["hop when"] = "เงื่อนไขการย้ายเซิร์ฟเวอร์",
    ["idle"] = "ว่าง",
    ["import"] = "นำเข้า",
    ["import config"] = "นำเข้าโปรไฟล์",
    ["import text"] = "ข้อความสำหรับนำเข้า",
    ["in bag"] = "อยู่ในกระเป๋า",
    ["info"] = "ข้อมูล",
    ["information"] = "ข้อมูล",
    ["interface"] = "หน้าต่างควบคุม",
    ["job id"] = "Job ID",
    ["join"] = "เข้าร่วม",
    ["join and stay"] = "เข้าเซิร์ฟเวอร์ที่กำหนด",
    ["join that server"] = "เข้าร่วมเซิร์ฟเวอร์นี้",
    ["keep eggs"] = "เก็บไข่ไว้",
    ["keep lab eggs"] = "เก็บไข่จากแล็บไว้",
    ["keep mutated"] = "เก็บตัวที่กลายพันธุ์ไว้",
    ["key"] = "คีย์",
    ["keybinds"] = "ปุ่มลัด",
    ["lab"] = "แล็บ",
    ["lab eggs"] = "ไข่แล็บ",
    ["lands in"] = "ตกในอีก",
    ["language"] = "ภาษา",
    ["last egg"] = "ไข่ล่าสุด",
    ["least players"] = "ผู้เล่นน้อยที่สุด",
    ["legendary"] = "ตำนาน",
    ["light dark zone"] = "โซนสว่างและมืด",
    ["load"] = "โหลด",
    ["loading"] = "กำลังโหลด",
    ["low"] = "ต่ำ",
    ["low graphics"] = "ลดคุณภาพกราฟิก",
    ["lower it if wins do not count"] = "ลดค่านี้หากชัยชนะไม่ถูกนับ",
    ["lowest rarity"] = "หายากน้อยที่สุด",
    ["lowest value"] = "มูลค่าต่ำสุด",
    ["lowest value first"] = "มูลค่าต่ำสุดก่อน",
    ["match"] = "เงื่อนไขตรงกัน",
    ["max"] = "สูงสุด",
    ["min"] = "ต่ำสุด",
    ["min value /s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["minimum value/s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["misc"] = "อื่น ๆ",
    ["money/s"] = "เงินต่อวินาที",
    ["mutate"] = "กลายพันธุ์",
    ["mutate filter"] = "ตัวกรองการกลายพันธุ์",
    ["mutate first"] = "เลือกกลายพันธุ์ก่อน",
    ["mutation"] = "การกลายพันธุ์",
    ["mutations"] = "การกลายพันธุ์",
    ["mythic"] = "มายาคติ",
    ["name"] = "ชื่อ",
    ["never"] = "ไม่เลย",
    ["never fuse"] = "ห้ามผสม",
    ["never sell"] = "ห้ามขาย",
    ["new"] = "ใหม่",
    ["new config name"] = "ชื่อโปรไฟล์ใหม่",
    ["next race"] = "แข่งครั้งถัดไป",
    ["night"] = "กลางคืน",
    ["night in"] = "กลางคืนในอีก",
    ["nitro"] = "ไนโตร",
    ["no egg matches your targets"] = "ไม่มีไข่ที่ตรงตามเงื่อนไข",
    ["no eggs found"] = "ไม่พบไข่",
    ["no matching eggs"] = "ไม่มีไข่ที่ตรงเงื่อนไข",
    ["no matching pets"] = "ไม่มีสัตว์เลี้ยงที่ตรงเงื่อนไข",
    ["no pets found"] = "ไม่พบสัตว์เลี้ยง",
    ["no targets"] = "ไม่มีเป้าหมาย",
    ["none"] = "ไม่มี",
    ["notification"] = "การแจ้งเตือน",
    ["notifications"] = "การแจ้งเตือน",
    ["off"] = "ปิด",
    ["on"] = "เปิด",
    ["only below /s"] = "เฉพาะที่มีมูลค่าต่ำกว่า/วินาที",
    ["only mutations"] = "เฉพาะแบบกลายพันธุ์ที่เลือก",
    ["only these eggs"] = "เลือกขโมยเฉพาะไข่เหล่านี้",
    ["only these pets"] = "เฉพาะสัตว์เลี้ยงที่เลือก",
    ["opacity"] = "ความทึบของหน้าต่าง",
    ["open"] = "เปิด",
    ["optimizer"] = "ปรับประสิทธิภาพ",
    ["other"] = "อื่น ๆ",
    ["paste a job id"] = "วาง Job ID",
    ["paste config text"] = "วางข้อความโปรไฟล์",
    ["pause"] = "พัก",
    ["pen"] = "คอกไข่",
    ["pet"] = "สัตว์เลี้ยง",
    ["pet bag"] = "กระเป๋าสัตว์เลี้ยง",
    ["pets"] = "สัตว์เลี้ยง",
    ["pick any"] = "เลือกได้หลายตัวเลือก",
    ["pick one"] = "เลือกหนึ่งตัวเลือก",
    ["pick to delete"] = "เลือกโปรไฟล์ที่จะลบ",
    ["pin"] = "ปักหมุด",
    ["ping everyone"] = "แท็กทุกคน",
    ["ping role id"] = "แท็กยศด้วย ID",
    ["ping user id"] = "แท็กผู้ใช้ด้วย ID",
    ["pinned"] = "ปักหมุดแล้ว",
    ["pins and keybinds"] = "ปักหมุดและปุ่มลัด",
    ["place"] = "วางไข่",
    ["place first"] = "เลือกวางก่อน",
    ["place id"] = "Place ID",
    ["place when"] = "เงื่อนไขการวาง",
    ["placed"] = "วางแล้ว",
    ["placing"] = "กำลังวางไข่",
    ["player"] = "ตัวละคร",
    ["player count"] = "จำนวนผู้เล่น",
    ["post fused eggs"] = "แจ้งไข่ที่ผสมแล้ว",
    ["post stolen eggs"] = "แจ้งไข่ที่ขโมยได้",
    ["post when bag is full"] = "แจ้งเมื่อกระเป๋าเต็ม",
    ["posted"] = "ส่งแล้ว",
    ["preview card"] = "แสดงตัวอย่างการ์ด",
    ["price"] = "ราคา",
    ["priority"] = "ลำดับความสำคัญ",
    ["profiles"] = "โปรไฟล์",
    ["progress"] = "ความคืบหน้า",
    ["quick bar 1"] = "แถบด่วน 1",
    ["quick bar 2"] = "แถบด่วน 2",
    ["quick bars"] = "แถบคำสั่งด่วน",
    ["race"] = "แข่งวิ่ง",
    ["race speed"] = "ความเร็วในการแข่ง",
    ["racer"] = "ตัวแข่ง",
    ["racing event"] = "กิจกรรมแข่งวิ่ง",
    ["rare"] = "หายาก",
    ["rare from"] = "ระดับความหายากตั้งแต่",
    ["rarities"] = "ระดับความหายาก",
    ["rarity"] = "ระดับความหายาก",
    ["ready"] = "พร้อม",
    ["ready now"] = "พร้อมตอนนี้",
    ["ready to place"] = "พร้อมวาง",
    ["refresh"] = "รีเฟรช",
    ["rejoin"] = "เข้าเซิร์ฟใหม่",
    ["rejoin on kick"] = "เข้าเกมใหม่เมื่อถูกเตะ",
    ["rejoin this server"] = "กลับเข้าเซิร์ฟเวอร์นี้",
    ["reset"] = "รีเซ็ต",
    ["reset all"] = "รีเซ็ตทั้งหมด",
    ["reset selection"] = "รีเซ็ตการเลือก",
    ["reset to defaults"] = "คืนค่าเริ่มต้นทั้งหมด",
    ["resetting carry"] = "กำลังรีเซ็ตการถือไข่",
    ["restore deleted"] = "กู้คืนโปรไฟล์ที่ลบ",
    ["resume"] = "ทำต่อ",
    ["rewards"] = "รางวัล",
    ["save"] = "บันทึก",
    ["save changes"] = "บันทึกการเปลี่ยนแปลง",
    ["saved configs"] = "โปรไฟล์ที่บันทึก",
    ["scrambled"] = "ปั่นเปลี่ยนสภาพ",
    ["search"] = "ค้นหา",
    ["search servers"] = "ค้นหาเซิร์ฟเวอร์",
    ["search..."] = "ค้นหา...",
    ["searching"] = "กำลังค้นหา",
    ["secret"] = "ลับ",
    ["select"] = "เลือก",
    ["select all"] = "เลือกทั้งหมด",
    ["sell"] = "ขาย",
    ["sell cheapest egg when bag is full"] = "ขายไข่ราคาต่ำสุดเมื่อกระเป๋าเต็ม",
    ["sell matching eggs now"] = "ขายไข่ที่ตรงเงื่อนไขทันที",
    ["sell matching lab eggs now"] = "ขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now"] = "ขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    ["sell rarities"] = "ระดับที่จะขาย",
    ["send a test post"] = "ส่งข้อความทดสอบ",
    ["server"] = "เซิร์ฟเวอร์",
    ["server hop"] = "ย้ายเซิร์ฟเวอร์",
    ["session"] = "ข้อมูลรอบนี้",
    ["session time"] = "เวลาในรอบนี้",
    ["set active"] = "ตั้งให้ใช้งาน",
    ["set as active config"] = "ตั้งเป็นโปรไฟล์ที่ใช้งาน",
    ["settings"] = "ตั้งค่า",
    ["shooting star"] = "ดาวตก",
    ["shop items"] = "สินค้าในร้าน",
    ["show / hide ui"] = "แสดง / ซ่อนหน้าต่าง",
    ["show fps and ping"] = "แสดง FPS และ Ping",
    ["show quick bars"] = "แสดงแถบปุ่มลัด",
    ["skip eggs with"] = "ข้ามไข่ที่มี",
    ["skip mutated"] = "ข้ามสัตว์เลี้ยงที่กลายพันธุ์แล้ว",
    ["slipped"] = "หลุดมือ",
    ["sort by"] = "เรียงตาม",
    ["sort eggs"] = "เรียงไข่ตาม",
    ["speed boost"] = "เพิ่มความเร็ว",
    ["speed power"] = "พลังความเร็ว",
    ["star"] = "ดาวตก",
    ["star catch"] = "จับดาวตก",
    ["star event"] = "กิจกรรมดาว",
    ["status"] = "สถานะ",
    ["steal"] = "ขโมยไข่",
    ["steal an egg"] = "เกมขโมยไข่",
    ["steal filter eggs"] = "ขโมยไข่ตามตัวกรอง",
    ["steal first"] = "เลือกไข่ที่จะขโมยก่อน",
    ["steal from other players"] = "ขโมยไข่จากผู้เล่นอื่น",
    ["steal lab eggs"] = "ขโมยไข่แล็บ",
    ["steal missing index"] = "ขโมยตัวที่ยังไม่ลงสมุด",
    ["steal missing index eggs"] = "ขโมยไข่ที่ยังไม่มีในสมุดสะสม",
    ["steal wisp eggs"] = "ขโมยไข่ Wisp",
    ["stealing"] = "กำลังขโมย",
    ["stolen"] = "ขโมยแล้ว",
    ["stop"] = "หยุด",
    ["success"] = "สำเร็จ",
    ["support"] = "ฝ่ายช่วยเหลือ",
    ["system"] = "ระบบ",
    ["task order"] = "ลำดับงาน",
    ["teleport"] = "วาร์ป",
    ["teleport to egg"] = "วาร์ปไปหาไข่",
    ["teleport zones"] = "โซนที่วาร์ปได้",
    ["teleporting"] = "กำลังย้ายตำแหน่ง",
    ["test"] = "ทดสอบ",
    ["theme"] = "ธีม",
    ["time"] = "เวลา",
    ["tip: you can also hold any option, or right-click it on pc, to pin it or set a key."] = "เคล็ดลับ: กดตัวเลือกค้างไว้ หรือคลิกขวาบน PC เพื่อปักหมุดหรือตั้งปุ่มลัด",
    ["tone"] = "โทนสี",
    ["top goes first. a carried egg is always delivered first, and before the field opens every task waits in the safe zone."] = "รายการบนสุดทำก่อน • ไข่ที่ถืออยู่จะถูกส่งก่อนเสมอ และจะรอที่เขตปลอดภัยก่อนสนามเปิด",
    ["treadmill"] = "ลู่วิ่ง",
    ["tries"] = "จำนวนครั้ง",
    ["trophies"] = "ถ้วยรางวัล",
    ["turn off"] = "ปิดทั้งหมด",
    ["turn off all toggles"] = "ปิดสวิตช์ทั้งหมด",
    ["tween"] = "เคลื่อนที่แบบ Tween",
    ["tween speed slider"] = "แถบปรับความเร็ว Tween",
    ["ui scale"] = "ขนาดหน้าต่าง",
    ["ui settings"] = "ตั้งค่าหน้าต่าง",
    ["uncommon"] = "ไม่ธรรมดา",
    ["unload hub"] = "ปิดฮับ",
    ["update"] = "อัปเดต",
    ["updates, keys, support"] = "อัปเดต • คีย์ • ช่วยเหลือ",
    ["upgrade"] = "อัปเกรด",
    ["use items"] = "ไอเทมที่ใช้",
    ["use pets"] = "ลำดับใช้สัตว์เลี้ยง",
    ["use power-ups"] = "ใช้ไอเทมเพิ่มพลัง",
    ["value"] = "มูลค่า",
    ["venyx"] = "VENYX",
    ["venyx / steal an egg"] = "Venyx / เกมขโมยไข่",
    ["venyx discord"] = "ดิสคอร์ด Venyx",
    ["version"] = "เวอร์ชัน",
    ["waiting"] = "กำลังรอ",
    ["waiting for server"] = "กำลังรอเซิร์ฟเวอร์",
    ["walk / sprint"] = "เดิน / วิ่งเร็ว",
    ["walk/sprint"] = "เดิน / วิ่งเร็ว",
    ["warning"] = "คำเตือน",
    ["webhook"] = "เว็บฮุก",
    ["webhook url"] = "ลิงก์ Webhook",
    ["welcome back"] = "ยินดีต้อนรับกลับ",
    ["welcome to venyx 1.0.2! join our discord for updates and support"] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["welcome to venyx 1.0.2! join our discord for updates and support."] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["what to post"] = "ข้อมูลที่จะส่ง",
    ["what's new"] = "มีอะไรใหม่",
    ["white"] = "ขาว",
    ["wins"] = "ชัยชนะ",
    ["wisp"] = "Wisp",
    ["wisp event"] = "กิจกรรม Wisp",
    ["worst"] = "ต่ำที่สุด",
    ["zones"] = "โซน",
    ["anti afk"] = "ป้องกันหลุดเมื่อไม่ขยับ",
    ["anti ragdoll"] = "ป้องกันตัวละครล้มกลิ้ง",
    ["auto banjo cricket"] = "ทำภารกิจจิ้งหรีดแบนโจอัตโนมัติ",
    ["auto butterfly bloom"] = "ทำกิจกรรมผีเสื้อผลิบานอัตโนมัติ",
    ["auto capture event egg"] = "ชิงไข่กิจกรรมอัตโนมัติ",
    ["auto craft essence"] = "สร้างแก่นพลังอัตโนมัติ",
    ["auto hit"] = "โจมตีอัตโนมัติ",
    ["auto reroll recipe"] = "สุ่มสูตรใหม่อัตโนมัติ",
    ["auto steal minigame egg"] = "ขโมยไข่จากมินิเกมอัตโนมัติ",
    ["auto trade in"] = "แลกไข่กับแล็บอัตโนมัติ",
    ["auto trade up"] = "แลกเปลี่ยนเป็นระดับสูงขึ้นอัตโนมัติ",
    ["auto wisp quest"] = "ทำภารกิจวิสป์อัตโนมัติ",
    ["banner"] = "ตู้สุ่ม",
    ["banner chance"] = "โอกาสได้รับจากตู้สุ่ม",
    ["boost speed"] = "เพิ่มความเร็ว",
    ["capture the egg"] = "ชิงไข่กิจกรรม",
    ["catch mode"] = "รูปแบบการจับ",
    ["catch priority"] = "ลำดับความสำคัญในการจับ",
    ["catch speed"] = "ความเร็วในการจับ",
    ["chase"] = "ไล่จับ",
    ["chase speed"] = "ความเร็วไล่ตาม",
    ["chasing butterflies"] = "กำลังไล่จับผีเสื้อ",
    ["chosen player"] = "ผู้เล่นที่เลือก",
    ["combat"] = "ต่อสู้",
    ["complete"] = "สำเร็จ",
    ["delivery method"] = "วิธีนำไข่กลับ",
    ["done, the enchanted tree is open"] = "เสร็จแล้ว ต้นไม้มนตร์เปิดใช้งานแล้ว",
    ["egg esp"] = "แสดงตำแหน่งไข่",
    ["ends in"] = "สิ้นสุดในอีก",
    ["esp size"] = "ขนาดการแสดงตำแหน่ง",
    ["experimental pets"] = "สัตว์เลี้ยงทดลอง",
    ["field eggs"] = "ไข่ในสนาม",
    ["fixed size"] = "ขนาดคงที่",
    ["god mode"] = "โหมดอมตะ",
    ["guard esp"] = "แสดงตำแหน่งยาม",
    ["hide sleeping guards"] = "ซ่อนยามที่กำลังหลับ",
    ["hit aura"] = "โจมตีรอบตัว",
    ["hit who"] = "เลือกผู้ที่จะโจมตี",
    ["hold each"] = "ถืออาวุธแต่ละชิ้นนาน",
    ["hold height"] = "ความสูงขณะถือ",
    ["icon"] = "ไอคอน",
    ["ignore traps"] = "ไม่ติดกับดัก",
    ["infinite jump"] = "กระโดดไม่จำกัด",
    ["instant prompts"] = "โต้ตอบได้ทันที",
    ["instant steal (admin treadmill)"] = "ขโมยทันที (ลู่วิ่งแอดมิน)",
    ["invisible"] = "ล่องหน",
    ["keep away"] = "รักษาระยะห่าง",
    ["lab banners"] = "ตู้สุ่มแล็บ",
    ["lab odds"] = "อัตราโอกาสออกสัตว์เลี้ยงจากแล็บ",
    ["lab stock"] = "สินค้าในแล็บ",
    ["minigame eggs"] = "ไข่จากมินิเกม",
    ["move"] = "เคลื่อนที่",
    ["movement"] = "การเคลื่อนที่",
    ["nearest player"] = "ผู้เล่นที่ใกล้ที่สุด",
    ["next"] = "ถัดไป",
    ["no admin boost right now"] = "ตอนนี้ไม่มีบูสต์แอดมิน",
    ["other pens esp"] = "แสดงตำแหน่งคอกผู้เล่นอื่น",
    ["others"] = "อื่น ๆ",
    ["pen egg esp"] = "แสดงตำแหน่งไข่ในคอก",
    ["place lab reward eggs"] = "วางไข่รางวัลจากแล็บ",
    ["player esp"] = "แสดงตำแหน่งผู้เล่น",
    ["protection"] = "การป้องกัน",
    ["racer selection"] = "เลือกตัวแข่ง",
    ["rarest"] = "หายากที่สุด",
    ["show"] = "แสดง",
    ["skip friends"] = "ไม่โจมตีเพื่อน",
    ["smart trade for essence"] = "แลกอย่างคุ้มค่าเพื่อรับแก่นพลัง",
    ["stage"] = "ด่าน",
    ["take it from the holder"] = "แย่งไข่จากผู้ที่ถืออยู่",
    ["trade"] = "แลก",
    ["tween speed"] = "ความเร็วการเคลื่อนที่แบบ Tween",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["use admin treadmill"] = "ใช้ลู่วิ่งของแอดมิน",
    ["use weapons"] = "อาวุธที่จะใช้",
    ["waiting for red light green light or t-rex run"] = "กำลังรอมินิเกม Red Light Green Light หรือ T-Rex Run",
    ["weapons"] = "อาวุธ",
    ["wisp companion"] = "คู่หูวิญญาณวิสป์",
    -- V1.3 • คำแปลตัวเลือกและชื่อฟังก์ชันเพิ่มเติมจากภาพชุดล่าสุด
    ["abyss ocean"] = "มหาสมุทรใต้พิภพ",
    ["all 106"] = "ทั้งหมด 106",
    ["all 108"] = "ทั้งหมด 108",
    ["always favorite"] = "ตั้งเป็นรายการโปรดเสมอ",
    ["amethyst"] = "อเมทิสต์",
    ["any"] = "ใดก็ได้",
    ["bird"] = "นก",
    ["cash booster"] = "ตัวคูณเงิน",
    ["celestial sunlion"] = "สิงโตสุริยันสวรรค์",
    ["cheetah"] = "เสือชีตาห์",
    ["cherry blossom"] = "ดอกซากุระ",
    ["cosmic"] = "จักรวาล",
    ["current"] = "ปัจจุบัน",
    ["desert"] = "ทะเลทราย",
    ["emerald"] = "มรกต",
    ["esp"] = "แสดงตำแหน่ง",
    ["essence"] = "แก่นพลัง",
    ["favorite equipped"] = "ตั้งสัตว์เลี้ยงที่สวมใส่เป็นรายการโปรด",
    ["forest"] = "ป่าไม้",
    ["frogfly"] = "กบแมลงวัน",
    ["growing 0"] = "กำลังเติบโต 0",
    ["highest value"] = "มูลค่าสูงสุด",
    ["highest weight"] = "น้ำหนักมากที่สุด",
    ["icon + text"] = "ไอคอนและข้อความ",
    ["in bag 97"] = "ในกระเป๋า 97",
    ["jungle"] = "ป่าดงดิบ",
    ["kitsune"] = "คิทสึเนะ",
    ["lake"] = "ทะเลสาบ",
    ["light dark"] = "สว่างและมืด",
    ["lizard"] = "กิ้งก่า",
    ["lowest weight"] = "น้ำหนักน้อยที่สุด",
    ["most valuable"] = "มูลค่าสูงสุด",
    ["move to egg"] = "วิธีเคลื่อนที่ไปหาไข่",
    ["nearest"] = "ใกล้ที่สุด",
    ["ostrich"] = "นกกระจอกเทศ",
    ["prehistoric"] = "ยุคก่อนประวัติศาสตร์",
    ["preview"] = "ตัวอย่าง",
    ["pure jellyfish"] = "แมงกะพรุนบริสุทธิ์",
    ["racing bat"] = "ไม้ตีสำหรับแข่ง",
    ["radiant"] = "เรืองแสง",
    ["ready 9"] = "พร้อม 9",
    ["sapphire"] = "ไพลิน",
    ["seahorse"] = "ม้าน้ำ",
    ["selected"] = "เลือกแล้ว",
    ["shop"] = "ร้านค้า",
    ["shortest time first"] = "เหลือเวลาน้อยที่สุดก่อน",
    ["showcase"] = "รายการไข่",
    ["skeleton horse"] = "ม้าโครงกระดูก",
    ["snow"] = "ดินแดนหิมะ",
    ["stacked turtle"] = "เต่าซ้อนชั้น",
    ["starry fox"] = "จิ้งจอกดวงดาว",
    ["step"] = "เคลื่อนที่ทีละก้าว",
    ["step to egg"] = "เคลื่อนที่ทีละก้าวไปหาไข่",
    ["text"] = "ข้อความ",
    ["three headed chicken"] = "ไก่สามหัว",
    ["time left"] = "เวลาที่เหลือ",
    ["time remaining"] = "เวลาที่เหลือ",
    ["titan temple"] = "วิหารไททัน",
    ["treadmill boost"] = "ตัวช่วยเร่งลู่วิ่ง",
    ["unfavorite pets not matching"] = "นำสัตว์เลี้ยงที่ไม่ตรงเงื่อนไขออกจากรายการโปรด",
    ["volcano"] = "ภูเขาไฟ",
    ["weight"] = "น้ำหนัก",
    ["weight first"] = "น้ำหนักมากสุดก่อน",
    ["wheel hamster"] = "แฮมสเตอร์ล้อวิ่ง",
    ["zone"] = "โซน",
    -- V1.4 • Additive Thai translations for remaining visible options (ZIGZAG)
    ["auto place eggs"] = "วางไข่อัตโนมัติ",
    ["bloom"] = "เบ่งบาน",
    ["choose what to place first"] = "เลือกวางก่อน",
    ["choose who to hit"] = "เลือกผู้ที่จะโจมตี",
    ["choose who to hit / hit who"] = "เลือกผู้ที่จะโจมตี",
    ["cracked"] = "แตกร้าว",
    ["defaults"] = "ค่าเริ่มต้น",
    ["diamond"] = "เพชร",
    ["egg holders"] = "ผู้ถือไข่",
    ["egg(s) ready to place"] = "ฟองพร้อมวาง",
    ["first hop after slider"] = "แถบปรับเวลาก่อนย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["from chilii"] = "จาก Chilii",
    ["game hud"] = "แผงควบคุมในเกม",
    ["golden"] = "ทอง",
    ["instant steps slider"] = "แถบปรับจำนวนก้าว",
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำ/วินาที",
    ["only at night"] = "เฉพาะตอนกลางคืน",
    ["parasite"] = "ปรสิต",
    ["place condition"] = "เงื่อนไขการวาง",
    ["rainbow"] = "สายรุ้ง",
    ["right after a steal"] = "ทันทีหลังขโมยไข่",
    ["shapeshift"] = "แปลงร่าง",
    ["silver"] = "เงิน",
    ["smallest"] = "ตัวเล็กที่สุด",
    ["spirit bloom"] = "เบ่งบานแห่งวิญญาณ",
    ["steal is idle"] = "เมื่อระบบขโมยไข่ว่าง",
    ["steal panel button on game hud"] = "แสดงปุ่มแผงขโมยไข่บน HUD",

    -- V1.5 • คำแปลเพิ่มเติมจากภาพ VENYX: แล็บ, ผีเสื้อ, ปักหมุด และตัวเลือกย่อย
    ["no egg matches here"] = "ไม่มีไข่ที่ตรงเงื่อนไขในเซิร์ฟเวอร์นี้",
    ["a rare egg spawned"] = "มีไข่หายากปรากฏแล้ว",
    ["waiting for daytime"] = "กำลังรอเวลากลางวัน",
    ["waiting for the next butterfly bloom"] = "กำลังรอกิจกรรมผีเสื้อผลิบานครั้งถัดไป",
    ["kept eggs are never placed, hatched or sold, in your bag or your pen."] = "ไข่ที่เลือกเก็บจะไม่ถูกนำไปวาง ฟัก หรือขาย ไม่ว่าจะอยู่ในกระเป๋าหรือคอกไข่",
    ["eggs to keep"] = "ไข่ที่จะเก็บไว้",
    ["most copies"] = "มีตัวซ้ำมากที่สุด",
    ["stand"] = "ยืนนิ่ง",
    ["patrol"] = "เดินตรวจตรา",
    ["circle"] = "เคลื่อนที่วนรอบ",
    ["emerald to sapphire"] = "มรกต → ไพลิน",
    ["sapphire to amethyst"] = "ไพลิน → อเมทิสต์",
    ["amethyst to radiant"] = "อเมทิสต์ → เรืองแสง",
    ["biohazard pets"] = "สัตว์เลี้ยงชีวอันตราย",
    ["unstable dna"] = "ดีเอ็นเอไม่เสถียร",
    ["stock lab eggs"] = "สำรองไข่สำหรับแล็บ",
    ["stock for banners"] = "สำรองไข่สำหรับตู้สุ่ม",
    ["biohazard pets eggs"] = "ไข่สัตว์เลี้ยงชีวอันตราย",
    ["experimental pets eggs"] = "ไข่สัตว์เลี้ยงทดลอง",
    ["unstable dna eggs"] = "ไข่ดีเอ็นเอไม่เสถียร",
    ["stock per egg"] = "จำนวนไข่ที่สำรองต่อชนิด",
    ["keeps eggs for recipes that have not shown up yet. % is how often a recipe asks for that egg."] = "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น",
    ["octophant"] = "อ็อกโทแฟนต์",
    ["slider"] = "แถบปรับค่า",
    ["only below /s slider"] = "แถบปรับมูลค่าสูงสุด/วินาที",
    ["+ pin"] = "+ ปักหมุด",
    ["steal / auto steal"] = "ขโมยไข่ / ขโมยอัตโนมัติ",
    ["steal / auto steal / filter"] = "ขโมยไข่ / อัตโนมัติ / ตัวกรอง",
    ["steal / auto steal / auto hop server"] = "ขโมยไข่ / อัตโนมัติ / ย้ายเซิร์ฟเวอร์",
    ["farm / pen / auto place"] = "ฟาร์ม / คอกไข่ / วางไข่อัตโนมัติ",
    ["farm / pen / auto hatch"] = "ฟาร์ม / คอกไข่ / ฟักไข่อัตโนมัติ",
    ["system / interface / game hud"] = "ระบบ / หน้าต่าง / แผงควบคุมในเกม",
    ["twilight"] = "ยามสนธยา",
    ["aurora"] = "แสงเหนือ",
    ["ocean"] = "มหาสมุทร",
    ["midnight"] = "เที่ยงคืน",
    ["sakura"] = "ซากุระ",
    ["onyx"] = "หินนิล",
    ["black"] = "ดำ",
    ["mono"] = "ขาวดำ",

    -- V1.6 • All circled English labels in the PIN / quick-bar picker.
    -- Only GUI text: these keys do not affect the original Venyx option IDs.
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำต่อวินาที",
    ["only below /s slider"] = "แถบปรับเกณฑ์มูลค่าต่ำกว่าต่อวินาที",
    ["tween speed slider"] = "แถบปรับความเร็วการเคลื่อนที่",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["instant steps slider"] = "แถบปรับจำนวนก้าวแบบทันที",
    ["first hop after slider"] = "แถบปรับเวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg slider"] = "แถบปรับจำนวนไข่สำรองต่อชนิด",
    ["upcoming banners button"] = "ปุ่มดูตู้สุ่มชุดถัดไป",
    ["race speed slider"] = "แถบปรับความเร็วแข่งวิ่ง",
    ["catch speed slider"] = "แถบปรับความเร็วในการจับ",
    ["hold height slider"] = "แถบปรับความสูงขณะถือ",
    ["keep away slider"] = "แถบปรับระยะห่าง",
    ["sell matching lab eggs now button"] = "ปุ่มขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now button"] = "ปุ่มขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    -- Additional button/slider variants generated by the same Venyx pin picker.
    ["sell matching eggs now button"] = "ปุ่มขายไข่ที่ตรงเงื่อนไขทันที",
    ["first hop after"] = "เวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg"] = "จำนวนไข่สำรองต่อชนิด",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["race speed"] = "ความเร็วแข่งวิ่ง",
    ["catch speed"] = "ความเร็วในการจับ",
    ["hold height"] = "ความสูงขณะถือ",
    ["keep away"] = "ระยะห่าง",

    -- V1.7 • Steal Panel ด้านขวา (เฉพาะข้อความ UI ไม่แตะข้อมูลตัวละคร/เกม)
    ["steal panel"] = "แผงขโมยไข่",
    ["auto steal on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["auto steal: on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal: off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["show: all"] = "แสดง: ทั้งหมด",
    ["show: ready"] = "แสดง: พร้อมขโมย",
    ["show: stolen"] = "แสดง: ขโมยแล้ว",
    ["show: available"] = "แสดง: ขโมยได้",
    ["show: none"] = "แสดง: ไม่มี",
    ["show: mine"] = "แสดง: ของฉัน",
    ["show: others"] = "แสดง: ของผู้อื่น",
    ["show: rarity"] = "แสดง: ระดับความหายาก",
    ["show: value"] = "แสดง: มูลค่า",
    -- ชื่อสัตว์ที่เห็นในภาพ: แปลเฉพาะป้ายชื่อที่ปรากฏ ไม่เปลี่ยนข้อมูลสัตว์
    ["gargoyle"] = "การ์กอยล์",
    ["spirit panda"] = "แพนด้าวิญญาณ",
    ["mantaris"] = "แมนทาริส",
    ["astral jackalope"] = "แจ็กคาโลปแห่งดวงดาว",
    ["demon hound"] = "สุนัขล่าเนื้อปีศาจ",
}

local function tidy(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end
local function key(text)
    return string.lower(tidy(text))
end

-- Translate count/status labels while preserving user values and item names.
local DYNAMIC = {
    -- V1.5 • แปลข้อความยาวที่ตัดบรรทัด และอัตราโอกาสการออกสัตว์เลี้ยงจากตู้สุ่ม
    {"^Keeps eggs for recipes that have not shown up yet%.%s*%% is how often a recipe asks for that egg%.$", function()
        return "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น"
    end},
    {"^(.+) %- 1 in ([%d%.]+) %(pity (%d+)%)$", function(rarity, chance, pity)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance .. " (การันตีที่ " .. pity .. " ครั้ง)"
    end},
    {"^(.+) %- 1 in ([%d%.]+)$", function(rarity, chance)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance
    end},
    {"^ALL (%d+)$", function(n) return "ทั้งหมด " .. n end},
    {"^READY (%d+)$", function(n) return "พร้อม " .. n end},
    {"^GROWING (%d+)$", function(n) return "กำลังเติบโต " .. n end},
    {"^IN BAG (%d+)$", function(n) return "ในกระเป๋า " .. n end},
    {"^%+?(%d+) hours? ago$", function(n) return n .. " ชั่วโมงก่อน" end},
    {"^(.+), changes in (%d+)m (%d+)s%s*Still needs: (.-)%s*Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(name, mins, secs, needed, trades, rerolls)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที\nยังต้องการ: " .. needed .. "\nรับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^(.+), changes in (%d+)m (%d+)s$", function(name, mins, secs)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที"
    end},
    {"^Still needs: (.+)$", function(items)
        return "ยังต้องการ: " .. items
    end},
    {"^Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(trades, rerolls)
        return "รับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^Pen (%d+/%d+) %- (%d+) egg%(s%) ready to place$", function(p, n)
        return "คอก " .. p .. " • ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) egg%(s%) can be mutated$", function(n)
        return "มีไข่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    {"^(%d+) pet%(s%) match$", function(n)
        return "พบสัตว์เลี้ยง " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) match$", function(n)
        return "พบไข่ " .. n .. " ฟอง"
    end},
    {"^(%d+) lab egg%(s%) match$", function(n)
        return "พบไข่แล็บ " .. n .. " ฟอง"
    end},
    {"^(%d+) x (.+) ready to fuse$", function(n, name)
        return name .. " พร้อมผสม " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) ready to place$", function(n)
        return "ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) hours? ago$", function(n)
        return n .. " ชั่วโมงก่อน"
    end},
    {"^(%d+) days? ago$", function(n)
        return n .. " วันก่อน"
    end},
    {"^(%d+) minutes? ago$", function(n)
        return n .. " นาทีก่อน"
    end},
    {"^Welcome back[,]?$", function()
        return "ยินดีต้อนรับกลับ"
    end},
}

-- In the pin picker, Venyx can use RichText to render the option name
-- in white and the control type ("slider" / "button") in gray.
-- A raw string like `Min value /s <font ...>slider</font>` did not match
-- the plain-string dictionary in V1.5 and therefore stayed in English.
-- Match by the VISIBLE text only, never edit option IDs/callbacks.
local function pinnedLabelTranslation(text)
    local exact = TH[key(text)]
    if exact then return exact end
    -- Generic fallback for further pinned entries: translate only when
    -- their base name is already known in the UI dictionary.
    local base = text:match("^(.-)%s+slider$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "แถบปรับ" .. baseThai end
    end
    base = text:match("^(.-)%s+button$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ปุ่ม" .. baseThai end
    end
    base = text:match("^(.-)%s+input$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ช่องกรอก" .. baseThai end
    end
    return nil
end

local function translate(raw)
    if type(raw) ~= "string" or raw == "" then return raw end
    local normalized = tidy(raw)
    local translated = TH[key(normalized)]
    local richText = false
    if not translated then
        -- A UI-only fix: tolerate styled suffixes and extra whitespace.
        -- Unknown descriptions, account/player names and user inputs
        -- remain unchanged, avoiding accidental alteration of game data.
        richText = normalized:find("<[^>]+>") ~= nil
        local visible = normalized
        if richText then
            visible = visible:gsub("<[^>]+>", "")
            visible = visible:gsub("&nbsp;", " "):gsub("&amp;", "&")
        end
        visible = tidy((visible:gsub("%s+", " ")))
        translated = pinnedLabelTranslation(visible)
    end
    if not translated then
        -- Preserve everything that is not a known UI label, e.g. egg names,
        -- player names, inventory amounts, settings data and custom inputs.
        for _, rule in ipairs(DYNAMIC) do
            local captures = {string.match(normalized, rule[1])}
            if #captures > 0 then
                translated = rule[2](table.unpack(captures))
                break
            end
        end
    end
    if not translated or translated == normalized then return raw end
    local pre = raw:match("^(%s*)") or ""
    local post = raw:match("(%s*)$") or ""
    -- For RichText pin labels, return clean Thai text rather than leaving
    -- English in font tags. This only affects those matching known labels.
    return pre .. translated .. post
end

local function isText(obj)
    return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
end

local function translateProperty(obj, property)
    if not STATE.Running or STATE.Busy[obj] then return end
    local ok, current = pcall(function() return obj[property] end)
    if not ok or type(current) ~= "string" then return end
    -- Never replace what the user has typed into search/config text boxes.
    if property == "Text" and obj:IsA("TextBox") then return end
    local updated = translate(current)
    if updated == current then return end
    STATE.Busy[obj] = true
    local success = pcall(function() obj[property] = updated end)
    STATE.Busy[obj] = nil
    if success then STATE.Count = STATE.Count + 1 end
end

local function watchText(obj)
    if not STATE.Running or STATE.Observed[obj] or not isText(obj) then return end
    STATE.Observed[obj] = true
    translateProperty(obj, "Text")
    bind(obj:GetPropertyChangedSignal("Text"):Connect(function()
        translateProperty(obj, "Text")
    end))
    if obj:IsA("TextBox") then
        translateProperty(obj, "PlaceholderText")
        bind(obj:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
            translateProperty(obj, "PlaceholderText")
        end))
    end
end

local function marker(text)
    if type(text) ~= "string" then return false end
    local lower = string.lower(text)
    return lower == "venyx" or lower == "venyx 🇹🇭"
        or lower:find("venyx discord", 1, true) ~= nil
        or lower:find("venyx sae", 1, true) ~= nil
end
local function isVenyxRoot(gui)
    if type(gui.Name) == "string" and string.lower(gui.Name):find("venyx", 1, true) then
        return true
    end
    for _,item in ipairs(gui:GetDescendants()) do
        if isText(item) then
            local ok, value = pcall(function() return item.Text end)
            if ok and marker(value) then return true end
        end
    end
    return false
end

local function observeRoot(root)
    if not STATE.Running or STATE.Roots[root] then return end
    STATE.Roots[root] = true
    for _,obj in ipairs(root:GetDescendants()) do watchText(obj) end
    bind(root.DescendantAdded:Connect(function(obj)
        -- Postpone one frame: Venyx may set new text just after parenting.
        task.defer(function()
            if not STATE.Running then return end
            watchText(obj)
            for _,nested in ipairs(obj:GetDescendants()) do watchText(nested) end
        end)
    end))
    print("[ZIGZAG VENYX THAI] พบ UI Venyx และเปิดตัวแปลไทยแล้ว")
end

local function containers()
    local sources = {CoreGui, PlayerGui}
    if type(gethui) == "function" then
        local ok, hidden = pcall(gethui)
        if ok and typeof(hidden) == "Instance" and hidden ~= CoreGui and hidden ~= PlayerGui then
            table.insert(sources, hidden)
        end
    end
    return sources
end

-- V1.7 • The optional Steal Panel can be a second ScreenGui rather than
-- a child of the Venyx main window. Detect it from its visible header
-- AND its distinct controls, then watch only that panel subtree.
local function isPanelLayoutContainer(instance)
    return instance:IsA("Frame") or instance:IsA("ScrollingFrame")
        or instance:IsA("CanvasGroup")
end

local function isStealPanelHeader(text)
    local name = key(text)
    return name == "steal panel" or name == "แผงขโมยไข่"
end

local function hasStealPanelControls(parent)
    local foundAuto, foundFilter, foundSteal = false, false, false
    for _, descendant in ipairs(parent:GetDescendants()) do
        if isText(descendant) then
            local ok, value = pcall(function() return descendant.Text end)
            if ok and type(value) == "string" then
                local label = key(value)
                if label == "auto steal on" or label == "auto steal off"
                    or label == "ขโมยไข่อัตโนมัติ: เปิด" or label == "ขโมยไข่อัตโนมัติ: ปิด" then
                    foundAuto = true
                elseif label == "show: all" or label == "แสดง: ทั้งหมด"
                    or label:sub(1, 6) == "show: " then
                    foundFilter = true
                elseif label == "steal" or label == "ขโมยไข่" then
                    foundSteal = true
                end
            end
        end
        if foundAuto and (foundFilter or foundSteal) then return true end
    end
    return false
end

local function findStandaloneStealPanel(gui)
    for _, obj in ipairs(gui:GetDescendants()) do
        if isText(obj) then
            local ok, value = pcall(function() return obj.Text end)
            if ok and isStealPanelHeader(value) then
                local parent = obj.Parent
                while parent and parent ~= gui do
                    if isPanelLayoutContainer(parent) and hasStealPanelControls(parent) then
                        return parent
                    end
                    parent = parent.Parent
                end
                -- An independent ScreenGui can be the panel itself.
                if hasStealPanelControls(gui) then return gui end
            end
        end
    end
    return nil
end

local function scan()
    for _,host in ipairs(containers()) do
        local ok, items = pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(items) do
                if obj:IsA("ScreenGui") then
                    if not STATE.Roots[obj] then
                        local found, answer = pcall(isVenyxRoot, obj)
                        if found and answer then observeRoot(obj) end
                    end
                    -- The Steal Panel may live in a separate game ScreenGui.
                    -- Observe only its own Frame, not all of the game's HUD.
                    if not STATE.Roots[obj] then
                        local okPanel, panel = pcall(findStandaloneStealPanel, obj)
                        if okPanel and panel and not STATE.Roots[panel] then
                            observeRoot(panel)
                        end
                    end
                end
            end
        end
    end
end

-- Initialize translator first so it can catch menus created by the loader.
task.spawn(function()
    while STATE.Running do
        pcall(scan)
        task.wait(3)
    end
end)

-- Keep exactly the user's ORIGINAL loader as the only external script.
-- Re-execution of this translator in one server will not start Venyx twice.
local session = tostring(game.PlaceId) .. ":" .. tostring(game.JobId)
local runLoader = (ENV.__ZIGZAG_VENYX_LOADED_SESSION ~= session)
if runLoader then
    local foundUI = false
    -- If the original Venyx was started separately, translate it in-place.
    for _,host in ipairs(containers()) do
        local ok, guis = pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(guis) do
                if obj:IsA("ScreenGui") then
                    local valid, result = pcall(isVenyxRoot, obj)
                    if valid and result then foundUI = true; break end
                end
            end
        end
        if foundUI then break end
    end
    if not foundUI then
        -- Set before launch: prevent duplicate execution if the user runs twice.
        ENV.__ZIGZAG_VENYX_LOADED_SESSION = session
        STATE.LoaderStarted = true
        task.spawn(function()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(SOURCE_URL))()
            end)
            if not ok then
                warn("[ZIGZAG VENYX THAI] Venyx loader error: " .. tostring(err))
                -- Allow user to retry if loading failed.
                if ENV.__ZIGZAG_VENYX_LOADED_SESSION == session then
                    ENV.__ZIGZAG_VENYX_LOADED_SESSION = nil
                end
            end
        end)
    else
        STATE.LoaderStarted = true
        ENV.__ZIGZAG_VENYX_LOADED_SESSION = session
        print("[ZIGZAG VENYX THAI] ใช้ Venyx ที่เปิดอยู่แล้ว ไม่โหลดซ้ำ")
    end
else
    STATE.LoaderStarted = true
    print("[ZIGZAG VENYX THAI] ไม่เรียก Venyx loader ซ้ำในเซิร์ฟเวอร์เดิม")
end
]=]
local TAIL = [=[-- V1.8 teleport-only lifecycle: queue a fresh translator for the next server.
-- Nothing below changes the original Venyx UI, controls or any game/character logic.
local _ZENV = (type(getgenv) == "function" and getgenv()) or _G
local _SESSION = tostring(game.PlaceId) .. ":" .. tostring(game.JobId)
local _VERSION = "V1.8"

local function findTeleportQueue()
    -- Do not use ipairs over a list containing nil holes: some executors
    -- expose the queue function only in the last few fallback locations.
    local candidates = {}
    local function add(fn)
        if type(fn) == "function" then table.insert(candidates, fn) end
    end
    add(_ZENV.queue_on_teleport)
    add(_ZENV.queueonteleport)
    if type(syn) == "table" then add(syn.queue_on_teleport) end
    if type(fluxus) == "table" then add(fluxus.queue_on_teleport) end
    if type(_G) == "table" then
        add(_G.queue_on_teleport)
        add(_G.queueonteleport)
    end
    add(queue_on_teleport)
    add(queueonteleport)
    return candidates[1]
end

-- The entire V1.7 translation payload is packaged inside the queued text.
-- The short tail re-queues the SAME payload at every following server hop.
-- No GitHub URL, file permission or extra script is required to carry translations.
if _ZENV.__ZIGZAG_VENYX_V18_QUEUED_SESSION ~= _SESSION then
    local queue = findTeleportQueue()
    if queue then
        local queued = "local HOP_RUN = true\nlocal CORE = "
            .. string.format("%q", CORE)
            .. "\nlocal TAIL = " .. string.format("%q", TAIL)
            .. "\n" .. TAIL
        local ok, err = pcall(queue, queued)
        if ok then
            _ZENV.__ZIGZAG_VENYX_V18_QUEUED_SESSION = _SESSION
            print("[ZIGZAG VENYX THAI] เตรียมแปลไทยให้เซิร์ฟเวอร์ถัดไปแล้ว")
        else
            warn("[ZIGZAG VENYX THAI] ไม่สามารถตั้งค่า queue_on_teleport: " .. tostring(err))
        end
    else
        -- Unsupported executors can instead auto-execute this SINGLE V1.8 file.
        warn("[ZIGZAG VENYX THAI] ตัวรันนี้ไม่มี queue_on_teleport; ต้องใช้ Auto Execute ของตัวรันหลังเปลี่ยนเซิร์ฟเวอร์")
    end
end

-- Guard duplicates AFTER queue registration, so the NEXT hop stays covered
-- even when another translator instance was already running in this server.
local _previous = _ZENV.__ZIGZAG_VENYX_THAI_STATE
if _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION == _SESSION
    and _previous and _previous.Running then
    return
end
if HOP_RUN and _previous and _previous.Running
    and _ZENV.__ZIGZAG_VENYX_LOADED_SESSION == _SESSION then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = _SESSION
    return
end

if HOP_RUN then
    -- The original Venyx has its own 'Auto load script' after server hops.
    -- V1.8 must ONLY restart the translator, NOT execute the Venyx loader again.
    -- Reloading the hub twice is a common reason for character/UI blinking.
    _ZENV.__ZIGZAG_VENYX_LOADED_SESSION = _SESSION
    -- Queued scripts can fire before LocalPlayer exists: wait without busy loop.
    local players = game:GetService("Players")
    while not players.LocalPlayer do task.wait(0.25) end
end

-- One exact, byte-for-byte copy of the working V1.7 UI translator.
_ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = _SESSION
local makeCore, compilationError = loadstring(CORE)
if type(makeCore) ~= "function" then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = nil
    warn("[ZIGZAG VENYX THAI] ตัวแปลเริ่มไม่ได้: " .. tostring(compilationError))
    return
end
local succeeded, runtimeError = pcall(makeCore)
if not succeeded then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = nil
    warn("[ZIGZAG VENYX THAI] ตัวแปลพบข้อผิดพลาด: " .. tostring(runtimeError))
end
]=]
-- V1.8 teleport-only lifecycle: queue a fresh translator for the next server.
-- Nothing below changes the original Venyx UI, controls or any game/character logic.
local _ZENV = (type(getgenv) == "function" and getgenv()) or _G
local _SESSION = tostring(game.PlaceId) .. ":" .. tostring(game.JobId)
local _VERSION = "V1.8"

local function findTeleportQueue()
    -- Do not use ipairs over a list containing nil holes: some executors
    -- expose the queue function only in the last few fallback locations.
    local candidates = {}
    local function add(fn)
        if type(fn) == "function" then table.insert(candidates, fn) end
    end
    add(_ZENV.queue_on_teleport)
    add(_ZENV.queueonteleport)
    if type(syn) == "table" then add(syn.queue_on_teleport) end
    if type(fluxus) == "table" then add(fluxus.queue_on_teleport) end
    if type(_G) == "table" then
        add(_G.queue_on_teleport)
        add(_G.queueonteleport)
    end
    add(queue_on_teleport)
    add(queueonteleport)
    return candidates[1]
end

-- The entire V1.7 translation payload is packaged inside the queued text.
-- The short tail re-queues the SAME payload at every following server hop.
-- No GitHub URL, file permission or extra script is required to carry translations.
if _ZENV.__ZIGZAG_VENYX_V18_QUEUED_SESSION ~= _SESSION then
    local queue = findTeleportQueue()
    if queue then
        local queued = "local HOP_RUN = true\nlocal CORE = "
            .. string.format("%q", CORE)
            .. "\nlocal TAIL = " .. string.format("%q", TAIL)
            .. "\n" .. TAIL
        local ok, err = pcall(queue, queued)
        if ok then
            _ZENV.__ZIGZAG_VENYX_V18_QUEUED_SESSION = _SESSION
            print("[ZIGZAG VENYX THAI] เตรียมแปลไทยให้เซิร์ฟเวอร์ถัดไปแล้ว")
        else
            warn("[ZIGZAG VENYX THAI] ไม่สามารถตั้งค่า queue_on_teleport: " .. tostring(err))
        end
    else
        -- Unsupported executors can instead auto-execute this SINGLE V1.8 file.
        warn("[ZIGZAG VENYX THAI] ตัวรันนี้ไม่มี queue_on_teleport; ต้องใช้ Auto Execute ของตัวรันหลังเปลี่ยนเซิร์ฟเวอร์")
    end
end

-- Guard duplicates AFTER queue registration, so the NEXT hop stays covered
-- even when another translator instance was already running in this server.
local _previous = _ZENV.__ZIGZAG_VENYX_THAI_STATE
if _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION == _SESSION
    and _previous and _previous.Running then
    return
end
if HOP_RUN and _previous and _previous.Running
    and _ZENV.__ZIGZAG_VENYX_LOADED_SESSION == _SESSION then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = _SESSION
    return
end

if HOP_RUN then
    -- The original Venyx has its own 'Auto load script' after server hops.
    -- V1.8 must ONLY restart the translator, NOT execute the Venyx loader again.
    -- Reloading the hub twice is a common reason for character/UI blinking.
    _ZENV.__ZIGZAG_VENYX_LOADED_SESSION = _SESSION
    -- Queued scripts can fire before LocalPlayer exists: wait without busy loop.
    local players = game:GetService("Players")
    while not players.LocalPlayer do task.wait(0.25) end
end

-- One exact, byte-for-byte copy of the working V1.7 UI translator.
_ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = _SESSION
local makeCore, compilationError = loadstring(CORE)
if type(makeCore) ~= "function" then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = nil
    warn("[ZIGZAG VENYX THAI] ตัวแปลเริ่มไม่ได้: " .. tostring(compilationError))
    return
end
local succeeded, runtimeError = pcall(makeCore)
if not succeeded then
    _ZENV.__ZIGZAG_VENYX_V18_STARTED_SESSION = nil
    warn("[ZIGZAG VENYX THAI] ตัวแปลพบข้อผิดพลาด: " .. tostring(runtimeError))
end
