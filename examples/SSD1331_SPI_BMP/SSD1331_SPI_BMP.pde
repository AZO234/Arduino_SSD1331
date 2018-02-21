#include <SSD1331_SPI.h>
#include "bmp.h"

extern BMP_t tLala;
extern BMP_t tXevious;

class SSD1331_SPI oMyDisplay(96, 64, 10, 8, 9);

void DisplayImage(class SSD1331_SPI* pDisplay, const int iX, const int iY, const BMP_t* ptImage) {
  unsigned int uiX, uiY;
  unsigned int uiLineSize;
  unsigned int uiColor;

  if(!ptImage) {
    return;
  }

  uiLineSize = ptImage->uiWidth * 2;

  for(uiY = 0; uiY < ptImage->uiHeight; uiY++) {
    for(uiX = 0; uiX < ptImage->uiWidth; uiX++) {
      uiColor = pgm_read_byte_near(ptImage->pucImageData + uiY * uiLineSize + uiX * 2);
      uiColor |= (unsigned int)pgm_read_byte_near(ptImage->pucImageData + uiY * uiLineSize + uiX * 2 + 1) << 8;
      pDisplay->DrawPixel(iX + uiX, iY + uiY, uiColor);
    }
  }
}

void setup() {
  // put your setup code here, to run once:
  oMyDisplay.Initialize(1);
}

void loop() {
  // put your main code here, to run repeatedly:
  DisplayImage(&oMyDisplay, 0, 0, &tLala);
  delay(5000);
  DisplayImage(&oMyDisplay, 0, 0, &tXevious);
  delay(5000);
}