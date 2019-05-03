  ; Clip origional NWM short, medium, and long range land model forecast into ACT, ACF and AL state domain
  ; Time: 12.11.2018 until now
  ; short range filename    20181210.t16(00-23)z.land.f005(001-018).conus.nc
  ; medium range filename   20181209.t18(00-18)z.land.f123(003-240).conus.nc
  ; long range filename     20181211.t00(00-18)z.land_4.f024(024-720).conus.nc 

  ;------- define domain & time range ------------------------------------------------
  x1 = 3039    ;lon1 = -88.71   x1 = 757,859.145  
  x2 = 3643    ;lon2 = -83.143  x2 = 1,289,672.708
  y1 = 826     ;lat2 = 29.351   y2 = -1,088,418.479
  y2 = 1523    ;lat1 = 35.378   y1 = -428,017.158 

  clipdate = getenv("CLIPDATE")
  bedate = clipdate ;Attention! Date range can't exceed one months, for example, 20181130-20181202 is illegal. 
  endate = clipdate ;Attention! Date range can't exceed one months 

  ;-------- main program --------------------------------------------------------------
  rdate = bedate
  do while(rdate.le.endate)
  
   ;------------ short range forecast -------------------------------------------------
  	do shour = 00,23;23
  	  do sterm = 001,018;018
       
       ;-------- land model output ----------------------------------------------------
  	    Ifilename = "//***Please use your own route***//"+rdate+".t"+sprinti("%0.2i",shour)+"z.land.f"+sprinti("%0.3i",sterm)+".conus.nc"
  	    Ifid = addfile(Ifilename, "r")
        if (.not.(ismissing(Ifid))) then 
    	   	temp = Ifid->SOILSAT_TOP(:,y1:y2,x1:x2)  ; Origional size is 4608x3840x1, _FillValue = -9999000, long_name = 'fraction of soil saturation, top 2 layers' 
          fsoil = rm_single_dims(temp)
    	    fsoil@_FillValue = -9999000
          fsoil@long_name = "fraction of soil saturation, top 2 layers"
          fsoil@units = "fraction"
          Ofilename = "//***Please use your own route***//"+rdate+".t"+sprinti("%0.2i",shour)+"z.land.f"+sprinti("%0.3i",sterm)+".clip.conus.nc"
          if ( isfilepresent( Ofilename ) ) then
            system ("/bin/rm "+Ofilename)
          end if
          Ofid = addfile(Ofilename,"c") 
          Ofid->SOILSAT_TOP = fsoil
          delete(Ifilename)
          delete(Ifid)
          delete(temp)
          delete(fsoil)
          delete(Ofilename)
          delete(Ofid)
        end if      
      end do
    end do
	 
	;------------ medium range forecast -------------------------------------------------
  	do shour = 00,00,06;18   ;Because forecast at 6 o'clock am contain files which can't be read in. I am not sure the reason.
  	  do sterm = 003,240,003;240

        ;-------- land model output ---------------------------------------------------

        Ifilename = "//***Please use your own route***//"+rdate+".t"+sprinti("%0.2i",shour)+"z.land.f"+sprinti("%0.3i",sterm)+".conus.nc"
        Ifid = addfile(Ifilename, "r")
        if (.not.(ismissing(Ifid))) then 
     	    temp = Ifid->SOILSAT_TOP(:,y1:y2,x1:x2)  ; Origional size is 4608x3840x1, _FillValue = -9999000, long_name = 'fraction of soil saturation, top 2 layers' 
          fsoil =  rm_single_dims(temp)     
          fsoil@_FillValue = -9999000
          fsoil@long_name = "fraction of soil saturation, top 2 layers"
          fsoil@units = "fraction"
          delete(temp)
          
          temp = Ifid->SOIL_M(:,y1:y2,:,x1:x2)     ; Origional size is 4608x4x3840x1,_FillValue= -999900, long_name = 'volumetric soil moisture'
          vsoil = rm_single_dims(temp)
          vsoil@_FillValue = -9999000
          vsoil@long_name = "volumetric soil moisture"
          vsoil@units = "m3 m-3"
          Ofilename = "//***Please use your own route***//"+rdate+".t"+sprinti("%0.2i",shour)+"z.land.f"+sprinti("%0.3i",sterm)+".clip.conus.nc"
          if ( isfilepresent( Ofilename ) ) then
            system ("/bin/rm "+Ofilename)
          end if
          Ofid = addfile(Ofilename,"c") 
          Ofid->SOILSAT_TOP = fsoil
          Ofid->SOIL_M = vsoil
          delete(temp)
          delete(vsoil)
          delete(Ofilename)
          delete(Ofid)
        end if 
      end do
    end do        
  ;------------ long range forecast -------------------------------------------------
  	do shour = 00,18,06;18
  	  do sterm = 024,720,024;720  
         do mem = 1,4;4
         
        ;-------- land model output -------------------------------------------------  
          Ifilename = "//***Please use your own route***//mem"+mem+"/"+rdate+".t"+sprinti("%0.2i",shour)+"z.land_"+mem+".f"+sprinti("%0.3i",sterm)+".conus.nc"
          Ifid = addfile(Ifilename, "r")
          if (.not.(ismissing(Ifid))) then
            temp = Ifid->SOILSAT_TOP(:,y1:y2,x1:x2)  ; Origional size is 4608x3840x1, _FillValue = -9999000, long_name = 'fraction of soil saturation, top 2 layers' 
            fsoil =  rm_single_dims(temp)     
    	      fsoil@_FillValue = -9999000
            fsoil@long_name = "fraction of soil saturation, top 2 layers"
            fsoil@units = "fraction"   
            Ofilename = "//***Please use your own route***//mem"+mem+"/"+rdate+".t"+sprinti("%0.2i",shour)+"z.land_"+mem+".f"+sprinti("%0.3i",sterm)+".clip.conus.nc"    
            if ( isfilepresent( Ofilename ) ) then
              system ("/bin/rm "+Ofilename)
            end if
            Ofid = addfile(Ofilename,"c") 
            Ofid->SOILSAT_TOP = fsoil 
            delete(Ifilename)
            delete(Ifid)
            delete(temp)
            delete(fsoil)
            delete(Ofilename)
            delete(Ofid)
          end if 
        end do
       end do
     end do         
   ;------------ The end of extraction -----------------------------------------------                   
	rdate = rdate + 1
  end do  
 
