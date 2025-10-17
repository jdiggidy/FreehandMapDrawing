# Freehand Map Drawing

Your task is to create an iOS application that allows users to draw freehand lines and polygons on a Mapbox map.

## Requirements

1. **Map Display**: Use Mapbox iOS SDK to display a map centered on a default location of your choosing.

2. **Freehand Drawing**: Implement functionality that allows users to draw freehand lines and polygons on the map using touch input. Users should be able to:
   - Draw freehand lines (open paths)
   - Draw freehand polygons (closed shapes with fill)
   - See a preview of what they're drawing in real-time
   - Switch between view, line drawing, and polygon drawing modes

3. **Customization**: Allow users to customize the appearance of their drawings:
   - Select colors for line strokes
   - Select fill colors for polygons
   - Each drawing should retain its individual styling

4. **Drawing Management**: Provide a way for users to:
   - Delete individual drawings
   - Clear all drawings at once

5. **Persistence**: Save the drawn shapes to disk so that they persist across app reloads.