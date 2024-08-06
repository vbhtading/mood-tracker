const { useState } = React;
const { Button, TextField, Slider, Select, MenuItem, FormControl, InputLabel } = MaterialUI;

const App = () => {
  const [mood, setMood] = useState({
    date: new Date().toISOString().split('T')[0],
    overallMood: 5,
    energy: 5,
    anxiety: 5,
    stress: 5,
    sleep: 8,
    activities: [],
    notes: '',
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setMood(prevMood => ({ ...prevMood, [name]: value }));
  };

  const handleSliderChange = (name) => (_, value) => {
    setMood(prevMood => ({ ...prevMood, [name]: value }));
  };

  const handleActivityChange = (e) => {
    const { value } = e.target;
    setMood(prevMood => ({ ...prevMood, activities: value }));
  };

  const downloadMoodData = () => {
    const dataStr = JSON.stringify(mood, null, 2);
    const dataUri = 'data:application/json;charset=utf-8,'+ encodeURIComponent(dataStr);
    const exportFileDefaultName = `mood-tracker-${mood.date}.json`;

    const linkElement = document.createElement('a');
    linkElement.setAttribute('href', dataUri);
    linkElement.setAttribute('download', exportFileDefaultName);
    linkElement.click();
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-400 via-pink-500 to-red-500 p-8">
      <div className="max-w-3xl mx-auto bg-white rounded-xl shadow-2xl p-8">
        <h1 className="text-4xl font-bold text-center mb-8 text-gray-800">Mood Tracker</h1>
        <form className="space-y-6">
          <TextField
            fullWidth
            type="date"
            name="date"
            value={mood.date}
            onChange={handleChange}
            className="mb-4"
          />
          
          <div className="space-y-4">
            {['overallMood', 'energy', 'anxiety', 'stress'].map((item) => (
              <div key={item} className="space-y-2">
                <label className="block text-sm font-medium text-gray-700 capitalize">
                  {item.replace(/([A-Z])/g, ' \$1').trim()}
                </label>
                <Slider
                  value={mood[item]}
                  onChange={handleSliderChange(item)}
                  min={1}
                  max={10}
                  step={1}
                  marks
                  valueLabelDisplay="auto"
                />
              </div>
            ))}
          </div>

          <TextField
            fullWidth
            type="number"
            name="sleep"
            label="Hours of Sleep"
            value={mood.sleep}
            onChange={handleChange}
            inputProps={{ min: 0, max: 24 }}
          />

          <FormControl fullWidth>
            <InputLabel>Activities</InputLabel>
            <Select
              multiple
              name="activities"
              value={mood.activities}
              onChange={handleActivityChange}
              renderValue={(selected) => selected.join(', ')}
            >
              {['Exercise', 'Reading', 'Meditation', 'Socializing', 'Work', 'Hobbies'].map((activity) => (
                <MenuItem key={activity} value={activity}>
                  {activity}
                </MenuItem>
              ))}
            </Select>
          </FormControl>

          <TextField
            fullWidth
            multiline
            rows={4}
            name="notes"
            label="Notes"
            value={mood.notes}
            onChange={handleChange}
          />

          <Button
            variant="contained"
            color="primary"
            onClick={downloadMoodData}
            className="w-full py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white font-bold rounded-lg shadow-lg hover:from-purple-600 hover:to-pink-600 transition duration-300"
          >
            Download Mood Data
          </Button>
        </form>
      </div>
    </div>
  );
};
