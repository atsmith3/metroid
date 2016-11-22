from PIL import Image

# im = Image.open("../Desktop/sprites/NEW/Samus_jumping_forward.png") #Can be many different formats.
# im = Image.open("../Desktop/sprites/NEW/enemy3.png") #Can be many different formats.
im = Image.open("../sprites/NEW/enemy2.png") #Can be many different formats.
pix = im.load()
minDistance = -1
closestColorList = list()
pallette = [(255,111,207,255), (44,92,10,255),(248,146,56,255),(156,0,18,255), (0, 255, 128), (0,0,128), (0,128,255), (255,255,255), (0,0,0), (0,0,255), (102,102,102), (0,255,255),(0,255,0), (64,128,0),(255,0,0),(255,102,102),(128,0,0),(248,146,56),(232,146,41),(27,175,0),(19,137,13),(255,49,62),(234,228,94),(126,0,246),(47,151,209),(156,89,33),(82,105,250),(43,93,83),(13,65,63),(37,75,258),(148,148,118),(60,70,17),(63,71,73),(34,28,28),(4,35,248),(186,0,37),(126,0,246),(103,0,183)]
xsize = im.size[0]
ysize = im.size[1]
print(im.size) #Get the width and hight of the image for iterating over
print(len(pallette))
for y in range(ysize):
    for x in range(xsize):
        for color in range(len(pallette)):
            distance = (pix[x,y][0]-pallette[color][0])**2+(pix[x,y][1]-pallette[color][1])**2+(pix[x,y][2]-pallette[color][2])**2
            if distance < minDistance or minDistance < 0:
                minDistance = distance
                # closestColor = pallette[color]
                closestColor = color
        closestColorList.append(closestColor)
        minDistance = -1

# for y in range(ysize):
#     for x in range(xsize):
#         # print(closestColorList[x+y*xsize],end="")
#     print()

imw = Image.new( 'RGB', (xsize,ysize), "black") # create a new black
pixw = imw.load()
for y in range(ysize):
    for x in range(xsize):
        pixw[x,y] = pallette[closestColorList[x+y*xsize]] # Set the RGBA Value of the image (tuple)
imw.show()
