function locomotive() {
  gsap.registerPlugin(ScrollTrigger);

  const locoScroll = new LocomotiveScroll({
    el: document.querySelector("#main"),
    smooth: true ,
  });
  locoScroll.on("scroll", ScrollTrigger.update);

  ScrollTrigger.scrollerProxy("#main", {
    scrollTop(value) {
      return arguments.length
        ? locoScroll.scrollTo(value, 0, 0)
        : locoScroll.scroll.instance.scroll.y;
    },

    getBoundingClientRect() {
      return {
        top: 0,
        left: 0,
        width: window.innerWidth,
        height: window.innerHeight,
      };
    },

    pinType: document.querySelector("#main").style.transform
      ? "transform"
      : "fixed",
  });
  ScrollTrigger.addEventListener("refresh", () => locoScroll.update());
  ScrollTrigger.refresh();
}
locomotive();


const canvas = document.querySelector("canvas");
const context = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;


window.addEventListener("resize", function () {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  render();
});

function files(index) {
  var data = `
     ../../3d/male0001.png
     ../../3d/male0002.png
     ../../3d/male0003.png
     ../../3d/male0004.png
     ../../3d/male0005.png
     ../../3d/male0006.png
     ../../3d/male0007.png
     ../../3d/male0008.png
     ../../3d/male0009.png
     ../../3d/male0010.png
     ../../3d/male0011.png
     ../../3d/male0012.png
     ../../3d/male0013.png
     ../../3d/male0014.png
     ../../3d/male0015.png
     ../../3d/male0016.png
     ../../3d/male0017.png
     ../../3d/male0018.png
     ../../3d/male0019.png
     ../../3d/male0020.png
     ../../3d/male0021.png
     ../../3d/male0022.png
     ../../3d/male0023.png
     ../../3d/male0024.png
     ../../3d/male0025.png
     ../../3d/male0026.png
     ../../3d/male0027.png
     ../../3d/male0028.png
     ../../3d/male0029.png
     ../../3d/male0030.png
     ../../3d/male0031.png
     ../../3d/male0032.png
     ../../3d/male0033.png
     ../../3d/male0034.png
     ../../3d/male0035.png
     ../../3d/male0036.png
     ../../3d/male0037.png
     ../../3d/male0038.png
     ../../3d/male0039.png
     ../../3d/male0040.png
     ../../3d/male0041.png
     ../../3d/male0042.png
     ../../3d/male0043.png
     ../../3d/male0044.png
     ../../3d/male0045.png
     ../../3d/male0046.png
     ../../3d/male0047.png
     ../../3d/male0048.png
     ../../3d/male0049.png
     ../../3d/male0050.png
     ../../3d/male0051.png
     ../../3d/male0052.png
     ../../3d/male0053.png
     ../../3d/male0054.png
     ../../3d/male0055.png
     ../../3d/male0056.png
     ../../3d/male0057.png
     ../../3d/male0058.png
     ../../3d/male0059.png
     ../../3d/male0060.png
     ../../3d/male0061.png
     ../../3d/male0062.png
     ../../3d/male0063.png
     ../../3d/male0064.png
     ../../3d/male0065.png
     ../../3d/male0066.png
     ../../3d/male0067.png
     ../../3d/male0068.png
     ../../3d/male0069.png
     ../../3d/male0070.png
     ../../3d/male0071.png
     ../../3d/male0072.png
     ../../3d/male0073.png
     ../../3d/male0074.png
     ../../3d/male0075.png
     ../../3d/male0076.png
     ../../3d/male0077.png
     ../../3d/male0078.png
     ../../3d/male0079.png
     ../../3d/male0080.png
     ../../3d/male0081.png
     ../../3d/male0082.png
     ../../3d/male0083.png
     ../../3d/male0084.png
     ../../3d/male0085.png
     ../../3d/male0086.png
     ../../3d/male0087.png
     ../../3d/male0088.png
     ../../3d/male0089.png
     ../../3d/male0090.png
     ../../3d/male0091.png
     ../../3d/male0092.png
     ../../3d/male0093.png
     ../../3d/male0094.png
     ../../3d/male0095.png
     ../../3d/male0096.png
     ../../3d/male0097.png
     ../../3d/male0098.png
     ../../3d/male0099.png
     ../../3d/male0100.png
     ../../3d/male0101.png
     ../../3d/male0102.png
     ../../3d/male0103.png
     ../../3d/male0104.png
     ../../3d/male0105.png
     ../../3d/male0106.png
     ../../3d/male0107.png
     ../../3d/male0108.png
     ../../3d/male0109.png
     ../../3d/male0110.png
     ../../3d/male0111.png
     ../../3d/male0112.png
     ../../3d/male0113.png
     ../../3d/male0114.png
     ../../3d/male0115.png
     ../../3d/male0116.png
     ../../3d/male0117.png
     ../../3d/male0118.png
     ../../3d/male0119.png
     ../../3d/male0120.png
     ../../3d/male0121.png
     ../../3d/male0122.png
     ../../3d/male0123.png
     ../../3d/male0124.png
     ../../3d/male0125.png
     ../../3d/male0126.png
     ../../3d/male0127.png
     ../../3d/male0128.png
     ../../3d/male0129.png
     ../../3d/male0130.png
     ../../3d/male0131.png
     ../../3d/male0132.png
     ../../3d/male0134.png
     ../../3d/male0135.png
     ../../3d/male0133.png
     ../../3d/male0136.png
     ../../3d/male0137.png
     ../../3d/male0138.png
     ../../3d/male0139.png
     ../../3d/male0140.png
     ../../3d/male0141.png
     ../../3d/male0142.png
     ../../3d/male0143.png
     ../../3d/male0144.png
     ../../3d/male0145.png
     ../../3d/male0146.png
     ../../3d/male0147.png
     ../../3d/male0148.png
     ../../3d/male0149.png
     ../../3d/male0150.png
     ../../3d/male0151.png
     ../../3d/male0152.png
     ../../3d/male0153.png
     ../../3d/male0154.png
     ../../3d/male0155.png
     ../../3d/male0156.png
     ../../3d/male0157.png
     ../../3d/male0158.png
     ../../3d/male0159.png
     ../../3d/male0160.png
     ../../3d/male0161.png
     ../../3d/male0162.png
     ../../3d/male0163.png
     ../../3d/male0164.png
     ../../3d/male0165.png
     ../../3d/male0166.png
     ../../3d/male0167.png
     ../../3d/male0168.png
     ../../3d/male0169.png
     ../../3d/male0170.png
     ../../3d/male0171.png
     ../../3d/male0172.png
     ../../3d/male0173.png
     ../../3d/male0174.png
     ../../3d/male0175.png
     ../../3d/male0176.png
     ../../3d/male0177.png
     ../../3d/male0178.png
     ../../3d/male0179.png
     ../../3d/male0180.png
     ../../3d/male0181.png
     ../../3d/male0182.png
     ../../3d/male0183.png
     ../../3d/male0184.png
     ../../3d/male0185.png
     ../../3d/male0186.png
     ../../3d/male0187.png
     ../../3d/male0188.png
     ../../3d/male0189.png
     ../../3d/male0190.png
     ../../3d/male0191.png
     ../../3d/male0192.png
     ../../3d/male0193.png
     ../../3d/male0194.png
     ../../3d/male0195.png
     ../../3d/male0196.png
     ../../3d/male0197.png
     ../../3d/male0198.png
     ../../3d/male0199.png
     ../../3d/male0200.png
     ../../3d/male0201.png
     ../../3d/male0202.png
     ../../3d/male0203.png
     ../../3d/male0204.png
     ../../3d/male0205.png
     ../../3d/male0206.png
     ../../3d/male0207.png
     ../../3d/male0208.png
     ../../3d/male0209.png
     ../../3d/male0210.png
     ../../3d/male0211.png
     ../../3d/male0212.png
     ../../3d/male0213.png
     ../../3d/male0214.png
     ../../3d/male0215.png
     ../../3d/male0216.png
     ../../3d/male0217.png
     ../../3d/male0218.png
     ../../3d/male0219.png
     ../../3d/male0220.png
     ../../3d/male0221.png
     ../../3d/male0222.png
     ../../3d/male0223.png
     ../../3d/male0224.png
     ../../3d/male0225.png
     ../../3d/male0226.png
     ../../3d/male0227.png
     ../../3d/male0228.png
     ../../3d/male0229.png
     ../../3d/male0230.png
     ../../3d/male0231.png
     ../../3d/male0232.png
     ../../3d/male0233.png
     ../../3d/male0234.png
     ../../3d/male0235.png
     ../../3d/male0236.png
     ../../3d/male0237.png
     ../../3d/male0238.png
     ../../3d/male0239.png
     ../../3d/male0240.png
     ../../3d/male0241.png
     ../../3d/male0242.png
     ../../3d/male0243.png
     ../../3d/male0244.png
     ../../3d/male0245.png
     ../../3d/male0246.png
     ../../3d/male0247.png
     ../../3d/male0248.png
     ../../3d/male0249.png
     ../../3d/male0250.png
     ../../3d/male0251.png
     ../../3d/male0252.png
     ../../3d/male0253.png
     ../../3d/male0254.png
     ../../3d/male0255.png
     ../../3d/male0256.png
     ../../3d/male0257.png
     ../../3d/male0258.png
     ../../3d/male0259.png
     ../../3d/male0260.png
     ../../3d/male0261.png
     ../../3d/male0262.png
     ../../3d/male0263.png
     ../../3d/male0264.png
     ../../3d/male0265.png
     ../../3d/male0266.png
     ../../3d/male0267.png
     ../../3d/male0268.png
     ../../3d/male0269.png
     ../../3d/male0270.png
     ../../3d/male0271.png
     ../../3d/male0272.png
     ../../3d/male0273.png
     ../../3d/male0274.png
     ../../3d/male0275.png
     ../../3d/male0276.png
     ../../3d/male0277.png
     ../../3d/male0278.png
     ../../3d/male0279.png
     ../../3d/male0280.png
     ../../3d/male0281.png
     ../../3d/male0282.png
     ../../3d/male0283.png
     ../../3d/male0284.png
     ../../3d/male0285.png
     ../../3d/male0286.png
     ../../3d/male0287.png
     ../../3d/male0288.png
     ../../3d/male0289.png
     ../../3d/male0290.png
     ../../3d/male0291.png
     ../../3d/male0292.png
     ../../3d/male0293.png
     ../../3d/male0294.png
     ../../3d/male0295.png
     ../../3d/male0296.png
     ../../3d/male0297.png
     ../../3d/male0298.png
     ../../3d/male0299.png
     ../../3d/male0300.png
 `;
  return data.split("\n")[index];
}

const frameCount = 300;

const images = [];
const imageSeq = {
  frame: 1,
};

for (let i = 0; i < frameCount; i++) {
  const img = new Image();
  img.src = files(i);
  images.push(img);
}

gsap.to(imageSeq, {
  frame: frameCount - 1,
  snap: "frame",
  ease: `none`,
  scrollTrigger: {
    scrub: 0.15,
    trigger: `#page>canvas`,
    start: `top top`,
    end: `600% top`,
    scroller: `#main`,
  },
  onUpdate: render,
});

images[1].onload = render;

function render() {
  scaleImage(images[imageSeq.frame], context);
}

function scaleImage(img, ctx) {
  var canvas = ctx.canvas;
  var hRatio = canvas.width / img.width;
  var vRatio = canvas.height / img.height;
  var ratio = Math.max(hRatio, vRatio);
  var centerShift_x = (canvas.width - img.width * ratio) / 2;
  var centerShift_y = (canvas.height - img.height * ratio) / 2;
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.drawImage(
    img,
    0,
    0,
    img.width,
    img.height,
    centerShift_x,
    centerShift_y,
    img.width * ratio,
    img.height * ratio
  );
}
ScrollTrigger.create({
  trigger: "#page>canvas",
  pin: true,
  // markers:true,
  scroller: `#main`,
  start: `top top`,
  end: `600% top`,
});



gsap.to("#page1",{
  scrollTrigger:{
    trigger:`#page1`,
    start:`top top`,
    end:`bottom top`,
    pin:true,
    scroller:`#main`
  }
})
gsap.to("#page2",{
  scrollTrigger:{
    trigger:`#page2`,
    start:`top top`,
    end:`bottom top`,
    pin:true,
    scroller:`#main`
  }
})
gsap.to("#page3",{
  scrollTrigger:{
    trigger:`#page3`,
    start:`top top`,
    end:`bottom top`,
    pin:true,
    scroller:`#main`
  }
})