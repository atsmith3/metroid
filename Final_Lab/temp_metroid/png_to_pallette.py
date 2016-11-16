from PIL import Image

# im = Image.open("../Desktop/sprites/NEW/Samus_jumping_forward.png") #Can be many different formats.
# im = Image.open("../Desktop/sprites/NEW/enemy3.png") #Can be many different formats.
im = Image.open("../Desktop/linkdinprof.jpg") #Can be many different formats.
pix = im.load()
minDistance = -1
closestColorList = list()
pallette = [(255,111,207,255), (44,92,10,255),(248,146,56,255),(156,0,18,255)]
xsize = im.size[0]
ysize = im.size[1]
print(im.size) #Get the width and hight of the image for iterating over
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
