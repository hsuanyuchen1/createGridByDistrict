library(sf)
library(magrittr)
library(data.table)

createGrid = function(tpc, taiwanPoly){
  temp <- taiwanPoly[taiwanPoly$postcode == tpc,]
  grid <- st_make_grid(temp, cellsize = 0.00025, what = "centers")
  grid <- grid[temp] %>% st_as_sf()
  grid$postcode <- tpc
  
  st_write(grid, dsn = paste0("d:/Test/createGrid/data/", tpc, ".csv"), 
           layer_options="GEOMETRY=AS_XY")
  
}


taiwanPoly <- st_read("d:/Test/createGrid/TWN/Twn5000a2.TAB")
colnames(taiwanPoly)[5] <- "postcode"
taiwanPoly <- taiwanPoly[,c("postcode")]
upc <- unique(taiwanPoly$postcode)


sapply(upc, function(x) {createGrid(x, taiwanPoly)})



totalList <- list.files("d:/Test/createGrid/data/", full.names = T)
totalCsv <- lapply(totalList, function(x) fread(x)) %>% rbindlist()
fwrite(totalCsv[,c("X", "Y", "postcode")], "d:/Test/createGrid/TaiwanGrid.csv")
