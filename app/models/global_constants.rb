module GlobalConstants
  # This is a constants file that doesn't require a server restart and you can use these constants like GlobalConstants::STORAGE
  class Answers
    DEFAULT_STATUS = 0
    STATUSES = [["N/A", 0 ] ,["YES", 1 ] , ["NO", 2],["Resolved", 3] ]
  end

  class Users
    ROLES = {client: "client", admin: "admin", subordinate: "subordinates"} 
    STATUSES = [["N/A", 0 ] ,["Correct", 1 ] , ["Worng", 2] ]
  end

  class Options
  	DESCR = [
	          ["B/W (Black & white tv)","B/W (Black & white tv)"],
              ["C (Color tv)","C (Color tv)"],
              ["CP (Carrier packed)","CP (Carrier packed)"],
              ["PBO (Packed by owner)","PBO (Packed by owner)"],
              ["CD (Carrier Disassembled)","CD (Carrier Disassembled)"],
              ["DBO (Disassembled by owner)","DBO (Disassembled by owner)"],
              ["MCU (Mechnical condition unknown)","MCU (Mechnical condition unknown)"],
              ["PB (Professional Books)","PB (Professional Books)"],
              ["PE (Professional equipment)","PE (Professional equipment)"],
              ["PP (Professional papers)","PP (Professional papers)"],
  			]
    EXCEP = [
    		      ["BE (Bent)","BE (Bent)"],
                  ["BR (broken)","BR (broken)"],
                  ["BU (burned)","BU (burned)"],
                  ["CH (Chipped)","CH (Chipped)"],
                  ["CU (Content & condition unknown)","CU (Content & condition unknown)"],
                  ["D (Dented)","D (Dented)"],
                  ["F (Faded)","F (Faded)"],
                  ["G (Gouged)","G (Gouged)"],
                  ["L (Loose)","L (Loose)"],
                  ["M (Marred)","M (Marred)"],
                  ["MI (Mildew)","MI (Mildew)"],
                  ["MO (Motheaten)","MO (Motheaten)"],
                  ["R (Rubbed)","R (Rubbed)"],
                  ["RU (Rusted)","RU (Rusted)"],
                  ["SC (Scratched)","SC (Scratched)"],
                  ["SH (Short)","SH (Short)"],
                  ["SO (Soiled)","SO (Soiled)"],
                  ["SW (Stretch wrapped)","SW (Stretch wrapped)"],
                  ["T (Torn)","T (Torn)"],
                  ["W (Badly worn)","W (Badly worn)"],
                  ["Z (Cracked)","Z (Cracked)"],
    	    ]
    LOCATION = [
    			  ["Arm","Arm"],
                  ["Bottom","Bottom"],
                  ["Corner","Corner"],
                  ["Front","Front"],
                  ["Left","Left"],
                  ["Legs","Legs"],
                  ["Rear","Rear"],
                  ["Right","Right"],
                  ["Side","Side"],
                  ["Top","Top"],
                  ["Veneer","Veneer"],
                  ["Edge","Edge"],
                  ["Center","Center"],
                  ["Seat","Seat"],
                  ["Drawer","Drawer"],
                  ["Inside","Inside"],
                  ["Outside","Outside"],
                  ["Door","Door"]
    			]	    
  end
end


                 


                   



                  
