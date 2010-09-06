/* raw2payload. Convert our raw PPC code into a fancy C header */

#include <stdio.h>
#include <string.h>

static const char header[] = 
  "#ifndef __payloads_h__\n" \
  "#define __payloads_h__\n\n" \
  "const uint8_t PROGMEM jig_payload[] = {\n";

static const char footer[] = "};\n\n#endif // !__payloads_h__\n";
  
int main(int argc, char **argv)
{
  char buf[256];
  FILE *fi, *fo;
  int r, k;

  if (argc < 3) {
    fprintf(stderr, "Usage: %s <raw> <c header>\n", argv[0]);
    return 1;
  }

  fi = fopen(argv[1], "r");
  if (fi == NULL) {
    perror(argv[1]);
    return 1;
  }

  fo = fopen(argv[2], "w");
  if (fo == NULL) {
    perror(argv[2]);
    return 1;
  }

  r = strlen(header);
  if (fwrite(header, 1, r, fo) != r) {
    perror("fwrite");
    return 1;
  }

  while ((r = fread(buf, 1, 256, fi)) > 0) {
    for (k = 0; k < r; k++) {
      fprintf(fo, "0x%.2x, ", buf[k] & 0xff);
      if (k && !((k + 1) & 15))
	fprintf(fo, "\n");
    }
  }

  r = strlen(footer);
  if (fwrite(footer, 1, r, fo) != r) {
    perror("fwrite");
    return 1;
  }

  fclose(fi);
  fclose(fo);
  fprintf(stdout, "Header generated.\n");
  return 0;
}
