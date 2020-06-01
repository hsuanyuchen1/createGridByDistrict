library(sf)
#taiwanPoly <- st_read("e:/Sam/ToolBox/mapdata201803011040/TOWN_MOI_1070205/TOWN_MOI_1070205.shp")
taiwanPoly <- st_read("c:/Work/studty/createGridbyDistrict/Twn5000a2.TAB")
tpe <- taiwanPoly[taiwanPoly$COUNTYID == "A",]

neiHu <- tpe[tpe$TOWNID == "A14",] %>% na.omit()

grid <- st_make_grid(neiHu, cellsize = 0.001, what = "centers")
grid.sf <- st_as_sf(grid)
test <- st_join(grid.sf, neiHu, join=st_intersects)
grid <- grid[neiHu]
st_write(grid, dsn = "c:/Users/hsuanyuc/Desktop/neiHuGrid.csv", 
         layer_options="GEOMETRY=AS_XY")
